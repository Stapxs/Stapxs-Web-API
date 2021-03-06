package cn.stapxs.api.config;

import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

/**
 * @Version: 1.0
 * @Date: 2021/9/1 下午 5:17
 * @ClassName: WebAppInitializer
 * @Author: Stapxs
 * @Description TO DO
 **/
public class WebAppInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {
    @Override
    protected Class<?>[] getRootConfigClasses() {
        return new Class[]{cn.stapxs.api.config.AppRootConfig.class};
    }
    @Override
    protected Class<?>[] getServletConfigClasses() {
        return new Class[]{cn.stapxs.api.config.AppServiceConfig.class};
    }
    @Override
    protected String[] getServletMappings() {
        return new String[]{"/"};
    }
}
