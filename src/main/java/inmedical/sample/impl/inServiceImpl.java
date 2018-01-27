package inmedical.sample.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import inmedical.sample.service.inService;

@Service("inService")
public class inServiceImpl implements inService {

	@Resource(name = "inMapper")
	private inMapper inmapper;
	
	@Override
	public List<Map<String, Object>> selectall(Map<String, Object> map2) throws Exception {
	        
	    
	    //inmapper.insert2(map2);
		//inmapper.insert(map2);
		return inmapper.selectall(map2);
	}

	
   @Override
    public List<Map<String, Object>> selectall2(Map<String, Object> map2) throws Exception {
            
        
        inmapper.insert(map2);
        inmapper.insert2(map2);
        return inmapper.selectall(map2);
    }

}
