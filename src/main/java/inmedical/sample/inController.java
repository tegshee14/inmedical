package inmedical.sample;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import inmedical.sample.service.inService;

@EnableWebMvc
@Controller
public class inController {
	
	private static final Logger logger = LoggerFactory.getLogger(Controller.class);
	
	@Resource(name = "inService")
	private inService inservice;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) throws Exception {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		HashMap<String,Object> map2 = new HashMap<String,Object>();
	        map2.put("HAHA", "dawda");
	        map2.put("hoho", 1231231);
		List<Map<String,Object>> map = inservice.selectall(map2);
		System.out.println(map);
		model.addAttribute("rows", map );
		
		return "home";
	}
	
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public ModelAndView index(Locale locale, Model model) throws Exception {
		ModelAndView mv = new ModelAndView("index");
		return mv;
	}
	
	@RequestMapping(value = "/sample", method = RequestMethod.GET)
	public ModelAndView sample(Locale locale, Model model) throws Exception {
		ModelAndView mv = new ModelAndView("sample1");
		return mv;
	}
	
	
	
	@RequestMapping(value = "/wow")
	@ResponseBody
	public ModelAndView wow(@RequestBody Map<String, Object> dto) throws Exception {
		System.out.println(dto);
		System.out.println(dto);
		System.out.println(dto);
		ModelAndView mv = new ModelAndView("jsonView");
		  HashMap<String,Object> map2 = new HashMap<String,Object>();
          map2.put("HAHA", "dawda");
          map2.put("hoho", 1231231);
		List<Map<String,Object>> map = inservice.selectall(map2);
		mv.addObject("rows", map );
		return mv;
	}
	
	@RequestMapping(value = "/ajax")
	public ModelAndView ajax(Map<String, Object> map) throws Exception {
		ModelAndView mv = new ModelAndView("jsonView");
		System.out.println(map);
		System.out.println(map);
		System.out.println(map);
		return mv;
	}

}
