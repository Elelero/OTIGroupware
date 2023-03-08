package com.oti.groupware.approval.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oti.groupware.approval.dto.ApprovalLine;
import com.oti.groupware.approval.dto.Document;
import com.oti.groupware.approval.dto.DocumentContent;
import com.oti.groupware.approval.dto.DocumentFile;
import com.oti.groupware.approval.service.ApprovalLineService;
import com.oti.groupware.approval.service.ApprovalService;
import com.oti.groupware.common.Pager;
import com.oti.groupware.common.dto.Organization;
import com.oti.groupware.employee.dto.Employee;

import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
@RequestMapping(value="/approval")
public class ApprovalController {
	Document document;
	ApprovalLine approvalLine;
	DocumentFile documentFile;
	Pager pager;
	
	List<Document> documents;
	List<ApprovalLine> approvalLines;
	List<DocumentFile> documentFiles;
	List<Organization> organizations;
	List<List<ApprovalLine>> approvalLinesList;
	
	Map<Integer, List<Organization>> organizationsMap;
	
	@Autowired
	ApprovalService approvalService;
	
	@Autowired
	ApprovalLineService approvalLineService;
	
	@RequestMapping(value = "/main")
	public String main() {
		log.info("정보 로그");
		
		return "approval/main";
	}

	//기안함
	@RequestMapping(value = "/draftdocument", method=RequestMethod.GET)
	public String getDraftDocumentList(HttpSession session, Model model) {
		log.info("정보 로그");
		
		return getDraftDocumentList(1, session, model);
	}
	
	//기안함
	@RequestMapping(value = "/draftdocument/{pageNo}", method=RequestMethod.GET)
	public String getDraftDocumentList(@PathVariable int pageNo, HttpSession session, Model model) {
		log.info("정보 로그");
		
		String empId = ((Employee)session.getAttribute("employee")).getEmpId();
		pager = new Pager();
		
		documents = approvalService.getDraftDocumentList(pageNo, pager, empId);
		approvalLinesList = approvalLineService.getApprovalLinesList(documents);
		
		model.addAttribute("pager", pager);
		model.addAttribute("documents", documents);
		model.addAttribute("approvalLinesList", approvalLinesList);
		
		return "approval/draftdocument";
	}
	
	//임시저장함
	@RequestMapping(value = "/tempdocument", method=RequestMethod.GET)
	public String tempDocumentBox() {
		log.info("정보 로그");
		
		return "approval/tempdocument";
	}
	
	//반려/회수함
	@RequestMapping(value = "/returneddocument", method=RequestMethod.GET)
	public String returnedDocumentBox() {
		log.info("정보 로그");
		
		return "approval/returneddocument";
	}
	
	//결재대기함
	@RequestMapping(value = "/pendeddocument", method=RequestMethod.GET)
	public String getPendedDocumentList(HttpSession session, Model model) {
		log.info("정보 로그");
		
		return getPendedDocumentList(1, session, model);
	}
	
	//결재대기함
	@RequestMapping(value = "/pendeddocument/{pageNo}", method=RequestMethod.GET)
	public String getPendedDocumentList(@PathVariable int pageNo, HttpSession session, Model model) {
		log.info("정보 로그");
		
		String empId = ((Employee)session.getAttribute("employee")).getEmpId();
		pager = new Pager();
		
		documents = approvalService.getpendedDocumentList(pageNo, pager, empId);
		approvalLinesList = approvalLineService.getApprovalLinesList(documents);
		
		model.addAttribute("pager", pager);
		model.addAttribute("documents", documents);
		model.addAttribute("approvalLinesList", approvalLinesList);
		
		return "approval/pendeddocument";
	}
	
	//완결문서함
	@RequestMapping(value = "/completeddocument", method=RequestMethod.GET)
	public String completedDocumentBox() {
		log.info("정보 로그");
		
		return "approval/completeddocument";
	}
	
	//결재 문서 작성 화면
	@RequestMapping(value = "/approvalwrite", method=RequestMethod.GET)
	public String getApprovalWrite(HttpSession session) {
		log.info("정보 로그");
		
		return "approval/approvalwrite";
	}
	
	//결재 문서 작성 화면
	@RequestMapping(value = "/approvalwrite", method=RequestMethod.POST)
	public String postApprovalWrite(@RequestParam("document") String document, DocumentContent documentContent) {
		log.info("정보 로그");
		
		int result = approvalService.saveDraft(document, documentContent);
		
		return "redirect:approvalwrite";
	}
	
	//주소록 화면 요청
	@RequestMapping(value = "/organization", method=RequestMethod.GET)
	public String organization(Model model) {
		log.info("정보 로그");
		
		organizations = approvalService.getOrganization();
		organizationsMap = new HashMap<Integer , List<Organization>>();
		
		for (Organization organization : organizations) {
			int depId = organization.getDepId();
			
			List<Organization> list = organizationsMap.getOrDefault(depId, new ArrayList<Organization>());
			
			list.add(organization);
			
			organizationsMap.put(depId, list);
		}
		
		model.addAttribute("organizationsMapKeySet", organizationsMap.keySet());
		model.addAttribute("organizationsMap", organizationsMap);
		
		return "approval/organization";
	}
	
	//결재 문서 자세히 보기
	@RequestMapping(value = "/viewdetail/{docId}", method=RequestMethod.GET)
	public String getApprovalDetail(@PathVariable String docId, HttpSession session, Model model) {
		log.info("정보 로그");
		
		document = approvalService.readDocument(docId);
		
		String empId = ((Employee)session.getAttribute("employee")).getEmpId();
		approvalLines = approvalLineService.getApprovalLines(docId);
		
		for(ApprovalLine approvalLine : approvalLines) {
			if (empId.equals(approvalLine.getEmpId())) {
				model.addAttribute("reader", approvalLine);
			}
		}
		
		model.addAttribute("document", document);
		model.addAttribute("approvalLines", approvalLines);
		return "approval/viewdetail";
	}
	
	//결재 문서 승인 또는 반려 요청
	@RequestMapping(value = "/viewdetail/{docId}", method=RequestMethod.POST)
	public String postApprovalDetail(Document document, ApprovalLine approvalLine, @PathVariable("docId") String docId, HttpSession session, Model model) {
		log.info("정보 로그");
		
		//approval 승인 또는 반려 판별해서 처리
		System.out.println(approvalLine);
		System.out.println(document);
		approvalLineService.modifyApprovalLineDeterminedState(approvalLine, document);
		document.setDocReadYn("N");
		approvalService.updateDocumentReadState(document);
		if (approvalLine.getAprvLineOpinion() != null && "".equals(approvalLine.getAprvLineOpinion())) {
			approvalLineService.writeOpinion(approvalLine);
		}
		
		return "redirect:approval/viewdetail/" + docId;
	}
	
	//결재 문서 내용 요청
	@RequestMapping(value = "/viewdetail/{docId}/documentdetail", method=RequestMethod.GET)
	public @ResponseBody Document getDocumentDetail(@PathVariable String docId) {
		log.info("정보 로그");
		
		document = approvalService.readDocument(docId);
		
		return document;
	}
	
	//결재문서 열람 상태 변경 요청
	@RequestMapping(value = "/viewdetail/{docId}/open")
	public void openDocument(Document document, ApprovalLine approvalLine) {
		log.info("정보 로그");
		approvalLineService.modifyApprovalLineOpenState(approvalLine);
		approvalService.updateDocumentReadState(document);
	}
	
	//반려 의견 작성 화면 요청
	@RequestMapping(value = "/opinion/{approvalLineState}", method=RequestMethod.GET)
	public String writeOpinion(@PathVariable("approvalLineState") String approvalLineState, Model model) {
		log.info("정보 로그");
		if (approvalLineState.equals("approve")) {
			model.addAttribute("approvalLineState", "승인");
		}
		else if (approvalLineState.equals("return")){
			model.addAttribute("approvalLineState", "반려");
		}
		return "approval/opinion";
	}
	
}