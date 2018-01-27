package inmedical.common;

import java.util.ArrayList;

import org.springframework.web.method.annotation.MapMethodProcessor;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter;

/**
 * Spring���� ����ڰ� ����� Custom HandlerArgumentResolver�� �켱������ Spring���� �⺻���� �����ϴ� Map�� ó���ϴ� HandlerMethodArgumentResolver���� ����.
 * ��, Custom Annotation�� �̿��Ͽ� Map���� ����ڰ� ���� �����͸� ������ �� �۾��� ���� ����� Custom HandlerArgumentResolver����
 * Spring���� Map�� ó���ϴ� HandlerMethodArgumentResolver�� ���� ������ ������ ����ڰ� ����� Custom HandlerArgumentResolver�� �̸� ó���Ҽ� ����.
 * �� �κ��� �����ϴ� ���� Spring���� �����ϴ� �±׷θ����δ� �� ���� ����. Spring���� ����ϴ� Ŭ������ ���� Ŀ���͸���¡ �ؾ� �Ѵ�.
 * �̸����� RequestMappingHandlerAdapter �������̽��� ������ Ŭ������.
 * @since 2016.01.26
 * @version 1.0
 * @see
 *
 * <pre>
 * << �����̷�(Modification Information) >>
 *
 *   ������      ������          ��������
 *  -------    --------    ---------------------------
 *  2016.01.28  �����       ���� �ۼ�
 *  
 *  </pre>
 */
public class CustomRequestMappingHandlerAdapter extends RequestMappingHandlerAdapter {

    /**
     * RequestMappingHandlerAdapter �������̽��� afterPropertiesSet �޼ҵ� ����
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