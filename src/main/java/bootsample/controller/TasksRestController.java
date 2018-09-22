package bootsample.controller;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import bootsample.model.Task;
import bootsample.service.TaskService;

@RestController
public class TasksRestController {

	@Autowired
	TaskService taskService;
	
	@PostMapping(path = "/save-task", produces = MediaType.APPLICATION_JSON_VALUE, consumes = MediaType.APPLICATION_JSON_VALUE)
	public String saveTask(@RequestBody Task task) {
		task.setDateCreated(new Date());
		taskService.save(task);
		return "{\"msg\":\"success\"}";
	}
	
	@DeleteMapping(path = "/delete-task/{id}", produces = MediaType.APPLICATION_JSON_VALUE)
	public String deleteTask(@PathVariable("id") int id) {
		taskService.delete(id);
		return "{\"msg\":\"success\"}";
	}
}
