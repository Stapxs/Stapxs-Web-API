package cn.stapxs.api.config;

import com.alibaba.druid.pool.DruidDataSource;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.sql.DataSource;
import java.util.Properties;

/**
 * @Version: 1.0
 * @Date: 2021/9/1 下午 5:19
 * @ClassName: AppRootConfig
 * @Author: Stapxs
 * @Description TO DO
 **/

@Configuration
@ComponentScan("cn.stapxs.api")
@MapperScan("cn.stapxs.api.dao")
@EnableTransactionManagement //开启事务
@EnableAspectJAutoProxy //开启AspectJ自动代理
public class AppRootConfig {
    // 配置数据源
    @Bean
    public DataSource dataSource(JdbcConfig dbcp) {
        DruidDataSource druidDataSource = new DruidDataSource();
        druidDataSource.setDriverClassName(dbcp.getDriver());
        druidDataSource.setUrl(dbcp.getUrl());
        druidDataSource.setUsername(dbcp.getName());
        druidDataSource.setPassword(dbcp.getPassword());
        druidDataSource.setMinIdle(1);
        druidDataSource.setMaxActive(300000);
        druidDataSource.setDefaultAutoCommit(true);
        return druidDataSource;
    }

    // 配置 mail
    @Bean
    public JavaMailSenderImpl javaMailSender(mailConfig config) {
        JavaMailSenderImpl impl = new JavaMailSenderImpl();
        // 设置 mail 参数
        impl.setHost(config.getHost());
        impl.setPort(config.getPort());
        impl.setUsername(config.getUsername());
        impl.setPassword(config.getPassword());
        impl.setDefaultEncoding(config.getDefaultEncoding());
        // 额外配置
        Properties properties = new Properties();
        properties.setProperty("mail.smtp.timeout", String.valueOf(config.getTimeout()));
        properties.setProperty("mail.smtp.ssl.enable", "true");
        properties.setProperty("mail.smtp.auth", "true");
        impl.setJavaMailProperties(properties);
        // 返回
        return impl;
    }

    // 配置 mybatis
    @Bean
    public SqlSessionFactoryBean sqlSessionFactoryBean(DataSource ds) {
        SqlSessionFactoryBean bean = new SqlSessionFactoryBean();
        bean.setDataSource(ds);//配置数据源
        return bean;
    }

    //配置事务管理
    @Bean
    public DataSourceTransactionManager
    dataSourceTransactionManager(DataSource ds) {
        DataSourceTransactionManager dm = new DataSourceTransactionManager();
        dm.setDataSource(ds);
        return dm;
    }
}