package inmedical.common;

import java.util.ArrayList;

import org.springframework.web.method.annotation.MapMethodProcessor;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter;

/**
 * Spring에서 사용자가 등록한 Custom HandlerArgumentResolver의 우선순위가 Spring에서 기본으로 제공하는 Map을 처리하는 HandlerMethodArgumentResolver보다 낮다.
 * 즉, Custom Annotation을 이용하여 Map으로 사용자가 보낸 데이터를 받을때 이 작업을 위해 등록한 Custom HandlerArgumentResolver보다
 * Spring에서 Map을 처리하는 HandlerMethodArgumentResolver를 먼저 만나기 때문에 사용자가 등록한 Custom HandlerArgumentResolver가 이를 처리할수 없다.
 * 이 부분을 구현하는 것은 Spring에서 제공하는 태그로만으로는 할 수가 없다. Spring에서 사용하는 클래스를 직접 커스터마이징 해야 한다.
 * 이를위해 RequestMappingHandlerAdapter 인터페이스를 구현한 클래스임.
 * @since 2016.01.26
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.01.28  정대용       최초 작성
 *  
 *  </pre>
 */
public class CustomRequestMappingHandlerAdapter extends RequestMappingHandlerAdapter {

    /**
     * RequestMappingHandlerAdapter 인터페이스의 afterPropertiesSet 메소드 구현
     */
	@Override
	public void afterPropertiesSet() {
		super.afterPropertiesSet();

		if (getArgumentResolvers() != null) {
			ArrayList<HandlerMethodArgumentResolver> list = new ArrayList<HandlerMethodArgumentResolver>(getArgumentResolvers());
			MapMethodProcessor mapMethodProcessor = null;
			int size = list.size();
			for (int i = 0; i < size; i++) {
				HandlerMethodArgumentResolver resolver = list.get(i);
				if (resolver instanceof MapMethodProcessor) {
					mapMethodProcessor = (MapMethodProcessor) list.remove(i);
					break;
				}
			}

			if (mapMethodProcessor != null) {
				for (int i = 1; i < size; i++) {
					HandlerMethodArgumentResolver resolver = list.get(i);
					if (resolver instanceof CustomMapArgumentResolver) {
						if (i + 1 < size) {
							list.add(i + 1, mapMethodProcessor);
						} else {
							list.add(i, mapMethodProcessor);
						}
						break;
					}
				}
			}
		    System.out.println(list);
		    for (HandlerMethodArgumentResolver handlerMethodArgumentResolver : list) {
                System.out.println(handlerMethodArgumentResolver);
            }
			setArgumentResolvers(list);
		}
	}
}