package cn.stapxs.api.config;

import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;

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
//    @Override
//    public void onStartup(ServletContext servletContext) throws ServletException {
//        //配置字符过滤器
//        FilterRegistration.Dynamic encodingFilter = servletContext.addFilter("encodingFilter", new CharacterEncodingFilter());
//        encodingFilter.setInitParameter("encoding", "utf-8");
//        encodingFilter.setInitParameter("forceEncoding", "true");
//        encodingFilter.addMappingForUrlPatterns(EnumSet.of(DispatcherType.REQUEST, DispatcherType.FORWARD), false, "/*");
//        super.onStartup(servletContext);
//    }
}
