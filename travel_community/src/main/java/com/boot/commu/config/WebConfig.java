package com.boot.commu.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

	@Value("${resource.handler}")
	private String resourceHandler;

	@Value("${resource.location}")
	private String resourceLocation;

	public WebConfig() {
		System.out.println("resourceHandler = " + resourceHandler);
	}

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		System.out.println("resourceHandler = " + resourceHandler);
		System.out.println("resourceLocation = " + resourceLocation);
		registry.addResourceHandler(resourceHandler).addResourceLocations(resourceLocation);
	}

}