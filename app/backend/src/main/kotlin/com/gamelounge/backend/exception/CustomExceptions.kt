package com.gamelounge.backend.exception

class UsernameNotFoundException(message: String) : RuntimeException(message)
class WrongCredentialsException(message: String) : RuntimeException(message)
class SessionNotFoundException(message: String) : RuntimeException(message)
class LogoutFailedException(message: String) : RuntimeException(message)
class UsernameAlreadyExistException(message: String): RuntimeException(message)
class EmailNotFoundException(message: String): RuntimeException(message)
class TokenNotFoundException(message: String): RuntimeException(message)
class PasswordMismatchException(message: String): RuntimeException(message)
