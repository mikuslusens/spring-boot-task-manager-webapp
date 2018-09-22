package bootsample.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import bootsample.service.TaskService;

@Controller
public class MainController {

	@Autowired
	private TaskService taskService;
	
	/*@GetMapping("/")
	public String home(HttpServletRequest request) {
		request.setAttribute("mode", "MODE_TASKS");
		request.setAttribute("tasks", taskService.findAll());
		return "index";
	}*/
	
	@GetMapping("/")
	public String allTasks(HttpServletRequest request) {
		request.setAttribute("tasks", taskService.findAll());
		request.setAttribute("mode", "MODE_TASKS");
		return "index";
	}
	
	@GetMapping("/tasks")
	public String redirectToHome(HttpServletRequest request) {
		return allTasks(request);
	}
	
	@GetMapping("/new-task")
	public String newTask(HttpServletRequest request) {
		request.setAttribute("mode", "MODE_NEW");
		return "index";
	}
	
	
	
	@GetMapping("/tasks/{id}")
	public String updateTask(@PathVariable("id") int id, HttpServletRequest request) {
		request.setAttribute("task", taskService.findTask(id));
		request.setAttribute("mode", "MODE_UPDATE");
		return "index";
	}
	
	
}
