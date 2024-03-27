package org.example.controller

import org.example.User.User
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class UserController {

    @GetMapping("/users")
    fun getUsers(): List<User> {
        // Przykładowa lista użytkowników
        return listOf(
            User(username = "user1", password = "pass1"),
            User(username = "user2", password = "pass2")
        )
    }
}