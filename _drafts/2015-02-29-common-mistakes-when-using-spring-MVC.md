---
layout: post
title:      Common mistakes when using Spring MVC
date:       2015-02-12 12:31:19
summary:    everyone of us know that Spring use ContextLoaderListener to load Spring application context. Still, when declaring the DispatcherServlet, we need to create the servlet context definition file with the name "${servlet.name}-context.xml". Ever wonder why?
category:   nodejs
comments:   true
tags:       github-pages
---


#### Declare beans in Servlet context definition file

So, everyone of us know that Spring use ContextLoaderListener to load Spring application context. Still, when declaring the DispatcherServlet, we need to create the servlet context definition file with the name "${servlet.name}-context.xml". Ever wonder why?

#####Application Context Hierarchy

Not all developers know that Spring application context has hierarchy. Let look at this method

org.springframework.context.ApplicationContext.getParent()

It tells us that Spring Application Context has parent. So, what is this parent for?

If you download the source code and do a quick references search, you should find that Spring Application Context treat parent as its extension. If you do not mind to read code, let I show you one example of the usage in method BeanFactoryUtils.beansOfTypeIncludingAncestors():

{% highlight java %}
{
    if (lbf instanceof HierarchicalBeanFactory) {
    HierarchicalBeanFactory hbf = (HierarchicalBeanFactory) lbf;
    if (hbf.getParentBeanFactory() instanceof ListableBeanFactory) {
	 Map parentResult = 
				  beansOfTypeIncludingAncestors((ListableBeanFactory) hbf.getParentBeanFactory(), type);
	 ...
		}
	}
	return result;

}
{% endhighlight %}



If you go through the whole method, you will find that Spring Application Context scan to find beans in internal context before searching parent context. With this strategy, effectively, Spring Application Context will do a reverse breadth first search to look for beans.

#####ContextLoaderListener

This is a well known class that every developers should know. It helps to load the Spring application context from a pre-defined context definition file. As it implements ServletContextListener, the Spring application context will be loaded as soon as the web application is loaded. This bring indisputable benefit when loading the Spring container  that contain beans with @PostContruct annotation or batch jobs.

In contrast, any bean define in the servlet context definition file will not be constructed until the servlet is initialized. When does the servlet be initialized? It is indeterministic. In worst case, you may need to wait until users make the first hit to the servlet mapping URL to get the spring context loaded.

With the above information, where should you declare all your precious beans? I feel the best place to do so is the context definition file loaded by ContextLoaderListener and no where else. The trick here is the storage of ApplicationContext as a servlet attribute under the key

org.springframework.web.context.WebApplicationContext.ROOT_WEB_APPLICATION_CONTEXT_ATTRIBUTE   

Later, DispatcherServlet will load this context from ServletContext and assign it as the parent application context.

{% highlight java %}
{
    protected WebApplicationContext initWebApplicationContext() {
   WebApplicationContext rootContext =
      WebApplicationContextUtils.getWebApplicationContext(getServletContext());
   ...
}

}
{% endhighlight %}



Because of this behaviour, it is highly recommended to create an empty servlet application context definition file and define your beans in the parent context. This will help to avoid duplicating the bean creation when web application is loaded and guarantee that batch jobs are executed immediately.

Theoretically, defining the bean in servlet application context definition file make the bean unique and visible to that servlet only. However, in my 8 years of using Spring, I hardly found any use for this feature except defining Web Service end point.




####Declare Log4jConfigListener after ContextLoaderListener


This is a minor bug but it catch you when you do not pay attention to it. Log4jConfigListener is my preferred solution over -Dlog4j.configuration as we can control the log4j loading without altering server bootstrap process. 

Obviously, this should be the first listener to be declared in your web.xml. Otherwise, all of your effort to declare proper logging configuration will be wasted.

Duplicated Beans due to mismanagement of bean exploration

In the early day of Spring, developers spent more time typing on xml files than Java classes. For every new bean, we need to declare and wiring the dependencies ourselves, which is clean, neat but very painful. No surprise that later versions of Spring framework evolved toward greater usability. Now a day, developers may only need to declare transaction manager, data source, property source, web service endpoint and leave the rest to component scan and auto-wiring. 

I like these new features but this great power need to come with great responsibility; otherwise, thing will be messy quickly. Component Scan and bean declaration in XML files are totally independent. Therefore, it is perfectly possible to have identical beans of the same class in the bean container if the bean are annotated for component scan and declare manually as well. Fortunately, this kind of mistake should only happen with beginners.

The situation get more complicated when we need to integrate some embedded components into the final product. Then we really need a strategy to avoid duplicated bean declaration.



![desk](http://4.bp.blogspot.com/-jbh6Poz83lA/U7i8v-J6hoI/AAAAAAAABV8/dr112C7qOp0/s1600/spring_component.png)


The above diagram show a realistic sample of the kind of problems we face in daily life. Most of the time, a system is composed from multiple components and often, one component serves multiple product. Each application and component has it own beans. In this case, what should be the best way to declare to avoid duplicated bean declaration?

Here is my proposed strategy:

* Ensure that each component need to start with a dedicated package name. It makes our life easier when we need to do component scan.
* Don't dictate the team that develop the component on the approach to declare the bean in the component itself (annotation versus xml declaration). It is the responsibility of the developer whom packs the components to final product to ensure no duplicated bean declaration.
* If there is context definition file packed within the component, give it a package rather than in the root of classpath. It is even better to give it a specific name. For example src/main/resources/spring-core/spring-core-context.xml is way better than src/main/resource/application-context.xml. Imagine what can we do if we pack few components that contains the same file application-context.xml on the identical package!
* Don't provide any annotation for component scan (@Component, @Service or @Repository) if you already declare the bean in one context file.
* Split the environment specific bean like data-source, property-source to a separate file and reuse.
* Do not do component scan on the general package. For example, instead of scanning org.springframework package, it is easier to manage if we scan several sub-packages like org.springframework.core, org.springframework.context, org.springframework.ui,...


#####Conclusions

I hope you found the above tips useful for your daily usage. If there is any doubt or any other ideas, please help to feedback.

