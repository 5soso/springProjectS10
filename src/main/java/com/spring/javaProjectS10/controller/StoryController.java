package com.spring.javaProjectS10.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
@RequestMapping("/story")
public class StoryController {
	
	@RequestMapping(value = "/about", method = RequestMethod.GET)
	public String aboutGet() {
		return "story/about";
	}
}
