package cn.stapxs.api.config;

import org.springframework.context.annotation.*;
import org.springframework.web.servlet.config.annotation.*;

/**
 * @Version: 1.0
 * @Date: 2021/9/1 下午 4:28
 * @ClassName: AppServiceConfig
 * @Author: Stapxs
 * @Description TO DO
 **/
@Configuration
@ComponentScan("cn.stapxs.api")
@EnableWebMvc
public class AppServiceConfig implements WebMvcConfigurer {
    //配置jsp视图解析器
    @Override
    public void configureViewResolvers(ViewResolverRegistry registry) {
        registry.jsp("/web/",".jsp");
    }
    //配置静态资源处理
    @Override
    public void
    configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
        configurer.enable();
    }
}
