package com.qorlwn.web.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.apache.commons.mail.EmailException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.JsonNodeFactory;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.qorlwn.web.service.AdminService;
import com.qorlwn.web.util.Util;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private AdminService adminService;

	@Autowired
	private Util util;

	@GetMapping("/")
	public String adminIndex2() {
		return "forward:/admin/admin";// url경로명을 유지하고 화면내용만 갱신
	}

	@GetMapping("/admin")
	public String adminIndex() {
		return "admin/index";
	}

	@PostMapping("/login")
	public String adminLogin(@RequestParam Map<String, Object> map, HttpSession session) {
		// System.out.println(map);// {id=pororo, pw=1234567}
		Map<String, Object> result = adminService.login(map);
		// System.out.println(result);// {m_grade=5, m_name=뽀로로, count=1}

		if (util.objToInt(result.get("count")) == 1 && util.objToInt(result.get("m_grade")) > 5) {// object는 부등호 불가능
			// 세션 올리기
			session.setAttribute("m_id", map.get("id"));
			session.setAttribute("m_name", result.get("m_name"));
			session.setAttribute("m_grade", result.get("m_grade"));
			// 메인으로 이동
			return "redirect:/admin/main";
		} else {
			return "redirect:/admin/admin?error=login";
		}
	}

	@GetMapping("/main")
	public String main() {
		return "admin/main";
	}

	@GetMapping("/notice")
	public String notice(Model model) {
		List<Map<String, Object>> list = adminService.notice();
		// |nno |ntitle |ncontent |ndate |m_id |ndel |norifile |nrealfile
		model.addAttribute("notice", list);
		return "admin/notice";
	}

	@PostMapping("/noticeWrite")
	public String noticeWrite(@RequestParam("file") MultipartFile file, @RequestParam Map<String, Object> map, HttpSession session) {
		System.out.println(file);// org.springframework.web.multipart.support.StandardMultipartHttpServletRequest$StandardMultipartFile@69c2f465
		System.out.println(map);// {title=ㅛ, content=ㅛ}, file은 없음
		if (session.getAttribute("m_id") != null && util.objToInt(session.getAttribute("m_grade")) > 5) {
			if (file.getSize() > 0) {// !file.isEmpty()
				// 저장할 경로 뽑기
				String path = util.uploadPath();
				System.out.println("실제 경로 : " + path);
				// 실제 경로 : C:\eGovFrameDev-4.1.0-64bit\workspace\aug09\src\main\webapp\ upload

				// file정보 보기
				System.out.println(file.getOriginalFilename());// robot.png
				System.out.println(file.getSize());// 17719
				System.out.println(file.getContentType());// image/png

				// 중복피하기 위해 날짜+UUID+파일명.파일확장자
				// UUID 뽑기
				UUID uuid = UUID.randomUUID();

				// 날짜 뽑기
				LocalDateTime ldt = LocalDateTime.now();
				String format = ldt.format(DateTimeFormatter.ofPattern("YYYYMMddHHmmss"));// -, _ 빼야된다.
				String realFileName = format + uuid.toString() + file.getOriginalFilename();

				// 경로 + 저장할 파일명
				// File filePath = new File(path);// String 타입의 경로를 file 형태로 바꾼다.
				// File newFileName = new File(filePath + "/" + file.getOriginalFilename()); "/" == "\\"
				File newFileName = new File(path, realFileName);

				// 파일 업로드
				// 1. transfer
				// try {
				// 		file.transferTo(newFileName);// 파일을 내 서버로 복사
				// } catch (Exception e) {
				// 		e.printStackTrace();
				// }

				// 2. FileCopyUtils을 사용하기 위해서는 오리지널 파일을 byte[]로 만들어야 한다.
				try {
					FileCopyUtils.copy(file.getBytes(), newFileName);
				} catch (IOException e) {
					e.printStackTrace();
				}
				map.put("norifile", file.getOriginalFilename());
				map.put("nrealfile", realFileName);
			}
			map.put("m_id", session.getAttribute("m_id"));
			System.out.println(map);
			adminService.noticeWrite(map);
			return "redirect:/admin/notice";
		} else {
			return "redirect:/admin/admin?error=login";
		}

	}
	
	@GetMapping("/mail")
	public String mail() {
		return "admin/mail";
	}
	
	@PostMapping("/mail")
	public String mail(@RequestParam Map<String, Object> map) throws EmailException {
		System.out.println(map);// {title=ㅇ, to=ㅇ, content=ㅇ}
		util.htmlMailSender(map);
		return "admin/mail";
	}
	
	@ResponseBody
	@PostMapping("/noticeDetail")
	public String noticeDetail(@RequestParam("nno") int nno) {
		// System.out.println(nno);
		Map<String, String> map = adminService.noticeDetail(nno);
		System.out.println(map);
		
		// jackson 사용
		ObjectNode json = JsonNodeFactory.instance.objectNode();
		json.put("ncontent", map.get("ncontent"));
		json.put("nrealfile", map.get("nrealfile"));
		// json.put("result", adminService.noticeDetail(nno));
		
		/*
		Map<String, Object> map2 = new HashMap<String, Object>();
		map2.put("bno", 123);
		map2.put("btitle", 1234);
		
		ObjectMapper jsonMap = new ObjectMapper();
		try {
			json.put("map", jsonMap.writeValueAsString(map2));
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		*/
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping("/noticeHideShow")
	public String noticeHideShow(@RequestParam("nno") int nno) {
		int result = adminService.noticeHideShow(nno);
		
		ObjectNode json = JsonNodeFactory.instance.objectNode();
		json.put("result", result);
		return json.toString();
	}
	
	@RequestMapping(value = "/multiboard", method = RequestMethod.GET)
	public String multiboard(Model model) {
		List<Map<String, Object>> list = adminService.setupboard();
		model.addAttribute("list", list);
		return "admin/multiboard";
	}
	
	@PostMapping("/multiboard")
	public String multiboard(@RequestParam Map<String, Object> map) {
		System.out.println(map);
		adminService.multiboard(map);
		return "redirect:/admin/multiboard";
	}
	
	@GetMapping("/member")
	public ModelAndView member() {
		ModelAndView mv = new ModelAndView("admin/member");
		List<Map<String, Object>> list = adminService.memberList();
		mv.addObject("list", list);
		return mv;
	}
	
	@GetMapping("/gradeChange")
	public String gradeChange(@RequestParam Map<String, Object> map) {
		System.out.println(map);// {m_no=10, grade=9}
		adminService.gradeChange(map);
		return "redirect:/admin/member";
	}
	
	@GetMapping("/post")
	public String post(Model model, @RequestParam(name="cate", required = false, defaultValue = "0") int cate,
			@RequestParam Map<String, Object> map) {
		// 게시판 번호가 들어온다.
		// 게시판 관리번호를 다 불러온다.
		if(!map.containsKey("cate") || map.get("cate").equals(null) || map.get("cate").equals("")) {
			map.put("cate", 0);
		}
		System.out.println(cate);// 1
		System.out.println(map);// {searchV=ㅇ, cate=1}
		
		List<Map<String, Object>> boardlist = adminService.setupboard();
		model.addAttribute("boardlist", boardlist);
		// 게시글을 다 불러온다.
		List<Map<String, Object>> list = adminService.post(map);
		model.addAttribute("list", list);
		return "/admin/post";
	}
	
	@ResponseBody
	@PostMapping("/mbcontent")
	public String mbcontent(@RequestParam("mbno") int mbno) {
		// System.out.println(mbno);
		Map<String, String> map = adminService.mbcontent(mbno);
		// System.out.println(map);// {mbcontent=<p>떡꼬치~~</p>}
		ObjectNode json = JsonNodeFactory.instance.objectNode();
		json.put("mbcontent", map.get("mbcontent"));
		return json.toString();
	}
	
	@GetMapping("/corona")
	public String corona(Model model) throws IOException {// StrinbBuilder는 mutable
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1790387/covid19CurrentStatusKorea/covid19CurrentStatusKoreaJason"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=2FuvLNkoDGgjuFFIzsjapUacw5R9vxrUeOO20QOMPwYcIzxjFKkrRqICURsIaIrOikg7mbtiTUMicRDeWonPDw%3D%3D"); /*Service Key*/
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {// 통신 안됐을 때
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();
        // System.out.println(sb.toString());
        model.addAttribute("corona", sb.toString());
        // String > json
        ObjectMapper mapper = new ObjectMapper();
        // json > jackson jsonNode : json문서의 전체 혹은 일부를 나타낼 수 있는 객체
        JsonNode jsonN = mapper.readTree(sb.toString());// tree형태로
        System.out.println(jsonN.get("response").get("result").get(0));
        
        // java object > json : mapper.writeValue();
        // json > map(java object)
        Map<String, Object> result = mapper.readValue(
        		(jsonN.get("response").get("result").get(0)).toString(), new TypeReference<Map<String, Object>>(){
        		});
        model.addAttribute("result", result);
		return "/admin/corona";
	}
	
	@GetMapping("/air2")
	public String air() throws IOException, ParserConfigurationException, SAXException {
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B552584/ArpltnStatsSvc/getMsrstnAcctoRDyrg"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=2FuvLNkoDGgjuFFIzsjapUacw5R9vxrUeOO20QOMPwYcIzxjFKkrRqICURsIaIrOikg7mbtiTUMicRDeWonPDw%3D%3D"); /*Service Key*/
        urlBuilder.append("&returnType=xml"); /*xml 또는 json*/
        urlBuilder.append("&numOfRows=100"); /*한 페이지 결과 수*/
        urlBuilder.append("&pageNo=1"); /*페이지번호*/
        urlBuilder.append("&inqBginDt=20230801"); /*조회시작일자*/
        urlBuilder.append("&inqEndDt=20230829"); /*조회종료일자*/
        urlBuilder.append("&msrstnName=" + URLEncoder.encode("강남구", "UTF-8")); /*측정소명*/
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();
        System.out.println(sb.toString());
        
        // String > xml
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        // Document DOM parser가 입력받은 파일을 파싱하도록 요청
        Document document = builder.parse(new InputSource(new StringReader(sb.toString())));
        
        document.getDocumentElement().normalize();
        System.out.println(document);
		return "/admin/air";
	}
	
	  @GetMapping("/air")
	  public String air(Model model) throws Exception {
	      // String to xml
	      DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
	      DocumentBuilder builder = factory.newDocumentBuilder();
	      Document document = builder.parse("c:\\temp\\air.xml");
	
	      //document.getDocumentElement().normalize();
	      System.out.println(document.getDocumentElement().getNodeName());// xml의 최상위 tag값을 가져온다.
	      
	      NodeList list = document.getElementsByTagName("item");// 파싱할 태그 > 배열화, list.getLength() : 파싱할 리스트 수
	         //System.out.println("item length = " + list.getLength());
	         //System.out.println(list.toString());
	         ArrayList<Map<String, Object>> airList = new ArrayList<Map<String,Object>>();
	         for (int i = list.getLength() - 1; i >= 0; i--) {
	            NodeList childList = list.item(i).getChildNodes();
	            
	            Map<String, Object> value = new HashMap<String, Object>();
	            for (int j = 0; j < childList.getLength(); j++) {
	               Node node = childList.item(j);
	               if (node.getNodeType() == Node.ELEMENT_NODE) {
	            	  // Node는 공백, 주석, 태그, 텍스트 등 모든 속성을 포함
	            	  // Node.ELEMENT_NODE -> html에서 사용하는 HTMLElement
	            	  // Node.TEXT_NODE -> 일반 텍스트 요소
	            	  // Node.COMMENT_NODE -> 주석
	                  //System.out.println(node.getNodeName());
	                  //System.out.println(node.getTextContent());
	                  value.put(node.getNodeName(), node.getTextContent());
	               }
	            }
	            airList.add(value);
	         }
	         System.out.println("xml : " + airList);
	         model.addAttribute("list", airList);
	
	      return "/admin/air";
	   }
}
