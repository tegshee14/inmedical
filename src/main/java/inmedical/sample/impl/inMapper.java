package inmedical.sample.impl;


import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("inMapper")
public interface inMapper {

	public List<Map<String,Object>> selectall(Map <String,Object> map) throws Exception;

    public void insert(Map<String, Object> map)throws Exception;
    public void insert2(Map<String, Object> map)throws Exception;

}
