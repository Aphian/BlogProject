package com.gblog.web;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gblog.common.Pagination;
import com.gblog.dto.PostDTO;
import com.gblog.service.PostService;

@Controller
@RequestMapping("/post/*")
public class PostController {

	private static final Logger logger = LoggerFactory.getLogger(PostController.class);
	
	@Inject
	private PostService psvc;
	
//	@RequestMapping(value = "/list", method = RequestMethod.GET)
//	public void list(Model model) throws Exception {
//		logger.info("list 출력");
//		model.addAttribute("list", psvc.getPostList());
//	}
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model,
			@RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "1") int range
			) throws Exception {
		
		logger.info("list 출력");
		
		// 전체 게시글 개수
		int listCnt = psvc.getPostListCnt();
		
		// Pagination 객체 생성
		Pagination pgn = new Pagination();
		pgn.pageInfo(page, range, listCnt);
		
		model.addAttribute("pagination", pgn);
		model.addAttribute("list", psvc.getPostList(pgn));
		
		return "post/list";
	}

	@RequestMapping(value = "postForm", method = RequestMethod.GET)
	public String postFormGet(PostDTO pdto, Model model) throws Exception{
		logger.info("...write get...");
		return "post/postForm";
	}
	
//	@RequestMapping(value = "/postForm", method = RequestMethod.POST)
//	public String postFormPost(PostDTO pdto, RedirectAttributes reAttr) throws Exception{
//		psvc.insertPost(pdto);
//		reAttr.addFlashAttribute("result", "success");
//		return "redirect:/post/list";
//	}
	
	@RequestMapping(value = "/savePost", method = RequestMethod.POST)
	public String savePost(@ModelAttribute("postDTO") PostDTO pdto,
			@RequestParam("mode") String mode,
			RedirectAttributes rttr) throws Exception {
		
		if(mode.equals("edit")) {
			psvc.updatePost(pdto);
		}else {
			psvc.insertPost(pdto);
		}
		
		return "redirect:/post/list";
	}
	
	@RequestMapping(value = "/postContent", method = RequestMethod.GET)
	public void read(@RequestParam("post_id") int post_id, Model model) throws Exception {
		
		model.addAttribute(psvc.getPostContent(post_id));
		// key(name)을 사용하지 않을 경우 자동으로 클래스명을 소문자로 인식해서 지정해줌
	}
	
	@RequestMapping(value = "/modifyForm", method = RequestMethod.GET)
	public String modifyForm(@RequestParam("post_id") int post_id,
			@RequestParam("mode") String mode, Model model) throws Exception{
		
		model.addAttribute("postContent", psvc.getPostContent(post_id));
		model.addAttribute("mode", mode);
		model.addAttribute("postDTO", new PostDTO());
		return "post/postForm";
	}
	
	@RequestMapping(value = "/deletePost", method = RequestMethod.GET)
	public String deletePost(RedirectAttributes rttr, @RequestParam("post_id") int post_id) throws Exception {
		psvc.deletePost(post_id);
		return "redirect:/post/list";
	}
}
