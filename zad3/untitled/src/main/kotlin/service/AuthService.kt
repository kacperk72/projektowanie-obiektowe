package org.example.service

import org.example.User.User
import org.springframework.stereotype.Service
import javax.annotation.PostConstruct

interface AuthService {
    fun authorize(user: User): Boolean
}

@Service
class AuthServiceImpl : AuthService {

    @PostConstruct  // eager
    fun init() {
        println("AuthServiceImpl is initialized")
    }

    override fun authorize(user: User): Boolean {
        return user.username == "admin" && user.password == "password"
    }
}