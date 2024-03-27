package org.example.controller

import org.example.Auth.AuthRequest
import org.example.User.User
import org.example.service.AuthService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/auth")
class AuthController(@Autowired private val authService: AuthService) {

    @PostMapping("/authorize")
    fun authorize(@RequestBody user: User): String {
        return if (authService.authorize(user)) {
            "User authorized successfully."
        } else {
            "Authorization failed."
        }
    }

    @PostMapping("/login")
    fun login(@RequestBody authRequest: AuthRequest): ResponseEntity<String> {
        val user = User(username = authRequest.username, password = authRequest.password)
        return if (authService.authorize(user)) {
            ResponseEntity.ok("User authorized successfully.")
        } else {
            ResponseEntity.status(401).body("Authorization failed.")
        }
    }
}