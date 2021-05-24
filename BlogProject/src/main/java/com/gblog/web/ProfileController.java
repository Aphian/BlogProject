package com.gblog.web;

import java.io.File;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gblog.dto.ProfileDTO;
import com.gblog.service.ProfileService;

import utils.UploadFile;

@Controller
@RequestMapping("/profile/*")
public class ProfileController {

	private static final Logger LOGGER = LoggerFactory.getLogger(ProfileController.class);
	
	@Inject
	private ProfileService psvc;
	
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	 @RequestMapping(value = "/list", method = RequestMethod.GET)
	   public void list(Model model) throws Exception {
	      LOGGER.info(".... list 출력 ....");
	      
	      model.addAttribute("list", psvc.list());
	   }
	 
	 
	 @RequestMapping(value = "/read", method = RequestMethod.GET)
	 public void read(@RequestParam("user_id") String user_id, Model model) throws Exception{
		 
		 model.addAttribute(psvc.read(user_id));
	 }
	 
	
	 @RequestMapping(value = "/modify", method = RequestMethod.GET)
	 public void modifyGET(@RequestParam("user_id") String user_id, Model model) throws Exception{
		 LOGGER.info(".... modifyGET ....");
		 
		 model.addAttribute(psvc.read(user_id));
	 }
	 
	 @RequestMapping(value = "/modify", method = RequestMethod.POST)
	 public String modifyPOST (ProfileDTO pdto, MultipartFile file, RedirectAttributes reAttr) throws Exception{
		 LOGGER.info(".....modifyPOST.....");
		 
		 
		 String imgUploadPath = uploadPath + File.separator + "imgUpload"; // 이미지를 업로드할 폴더를 설정 = /uploadPath/imgUpload
			String ymdPath = UploadFile.calcPath(imgUploadPath); // 위의 폴더를 기준으로 연월일 폴더를 생성
			String fileName = null; // 기본 경로와 별개로 작성되는 경로 + 파일이름
			if (file.getOriginalFilename() != null && file.getOriginalFilename() != "" ) {
				// 파일 인풋박스에 첨부된 파일이 없다면(=첨부된 파일이 이름이 없다면)

				fileName = UploadFile.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
				

				// 상품 이미지를 원본 파일 경로 + 파일명 저장
				pdto.setProfile_photo(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
				

			} else { // 첨부된 파일이 없으면
				fileName = File.separator + "img" + File.separator + "none.png";
				
				// 미리 준비된 none.png파일을 대신 출력함

				pdto.setProfile_photo(fileName);
				
			
			}
		 
		 
		 psvc.modify(pdto);
		 
		 reAttr.addFlashAttribute("result", "수정되었습니다.");
		 
		 return "redirect:/profile/list";
	 }
	 
	 
	 
	 @RequestMapping(value = "/delete", method = RequestMethod.POST)
		public String delPage(@RequestParam("user_id") String user_id) throws Exception{
		 	LOGGER.info(".....remove.....");
		 
			psvc.remove(user_id);	
			
			return "redirect:/profile/list";
			
		}
	 

	 
	 

}
