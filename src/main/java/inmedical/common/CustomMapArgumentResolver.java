package inmedical.common;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.core.MethodParameter;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public class CustomMapArgumentResolver implements HandlerMethodArgumentResolver{
    
    Logger log = Logger.getLogger(this.getClass());
    
	@Override
	public boolean supportsParameter(MethodParameter parameter) {
		System.out.println(parameter.getParameterType());
		System.out.println(parameter.getParameterType());
		System.out.println(parameter.getParameterType());
	    return (Map.class.isAssignableFrom(parameter.getParameterType()) || List.class.isAssignableFrom(parameter.getParameterType()));//CommandMap.class.isAssignableFrom(parameter.getParameterType());
	}

	@Override
    public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer, 
                                NativeWebRequest webRequest, WebDataBinderFactory binderFactory ) throws Exception {
		HttpServletRequest httpServletRequest = webRequest.getNativeRequest(HttpServletRequest.class);
		MultipartHttpServletRequest multipartHttpServletRequest = webRequest.getNativeRequest(MultipartHttpServletRequest.class);
        Class<?> parameterType 		= parameter.getParameterType();
        HttpSession  session 		= (HttpSession) webRequest.getSessionMutex();
        Map<String, Object> map 	= (Map)httpServletRequest.getParameterMap();
        System.out.println(map);
        Set<String> keySet 			= map.keySet();
        Iterator<String> keyIterator = keySet.iterator();
        while (keyIterator.hasNext()) {
            String key          = (String) keyIterator.next();
            JSONParser parser   = new JSONParser();
            Object obj          = parser.parse( key );
            JSONObject jsonObj  = (JSONObject) obj;
            
            String jsonkey = "request";
            if(jsonObj.get(jsonkey) instanceof JSONObject) {
                JSONObject jsonObject = (JSONObject) jsonObj.get(jsonkey);
            //    commandMap.setMap(jsonObject);
            }else if(jsonObj.get(jsonkey) instanceof JSONArray) {
                JSONArray jsonArray = (JSONArray)jsonObj.get(jsonkey);
                JSONArray jarray    = new JSONArray();
                JSONObject jObject  = null;
                for (int i=0; i <jsonArray.size(); i++) {
                    jObject = (JSONObject)jsonArray.get(i);
                    jarray.add(jObject);
                }
              //  commandMap.setList(jarray);
            }
        }
        
        return 0;//commandMap;
    }

}
