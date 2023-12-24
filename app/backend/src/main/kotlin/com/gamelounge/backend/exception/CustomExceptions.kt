package com.gamelounge.backend.exception

class UsernameNotFoundException(message: String) : RuntimeException(message)
class WrongCredentialsException(message: String) : RuntimeException(message)
class SessionNotFoundException(message: String) : RuntimeException(message)
class LogoutFailedException(message: String) : RuntimeException(message)
class UsernameAlreadyExistException(message: String): RuntimeException(message)
class EmailNotFoundException(message: String): RuntimeException(message)
class TokenNotFoundException(message: String): RuntimeException(message)
class PasswordMismatchException(message: String): RuntimeException(message)
class UserNotFoundException(message: String): RuntimeException(message)
class PostNotFoundException(message: String) : RuntimeException(message)
class GameNotFoundException(message: String) : RuntimeException(message)
class UnauthorizedPostAccessException(message: String) : RuntimeException(message)
class UnauthorizedGameAccessException(message: String) : RuntimeException(message)
class CommentNotFoundException(message: String) : RuntimeException(message)
class UnauthorizedCommentAccessException(message: String) : RuntimeException(message)
class WrongRatingGameException(message: String) : RuntimeException(message)
class DuplicatedRatingGameException(message: String) : RuntimeException(message)
class CharacterNotFoundException(message: String) : RuntimeException(message)
class UnauthorizedCharacterAccessException(message: String) : RuntimeException(message)
class WrongGameStatusException(message: String) : RuntimeException(message)
class DuplicatedEditingRequestException(message: String) : RuntimeException(message)
class DuplicatedUserFollowing(message: String) : RuntimeException(message)
class DeletedGameException(message: String) : RuntimeException(message)
class DuplicateGameException(message: String) : RuntimeException(message)
class UnauthorizedLFGAccessException(message: String) : RuntimeException(message)
class LFGNotFoundException(message: String) : RuntimeException(message)
class UnauthorizedReportsAccessException(message: String) : RuntimeException(message)






