package com.gamelounge.backend.util
import com.gamelounge.backend.entity.*
import com.gamelounge.backend.model.DTO.*

object ConverterDTO {
    fun convertToPostDTO(post: Post) : PostDTO {
        return PostDTO(
            postId = post.postId,
            creatorUser = convertToUserDTO(post.user!!),
            title = post.title,
            content = post.content,
            creationDate = post.creationDate,
            upvotes = post.upvotes,
            downvotes = post.downvotes,
            totalComments = post.totalComments,
            category = post.category,
            tags = convertBulkToTagDTO(post.postTags)
        )
    }
    fun convertBulkToPostDTO(posts: List<Post>) : List<PostDTO> {
        return posts.map { convertToPostDTO(it) }
    }
    fun convertToCommentDTO(comment: Comment) : CommentDTO {
        return CommentDTO(
            commentId = comment.commentId,
            replyToCommentID = comment.replyToComment?.commentId,
            creatorUser = convertToUserDTO(comment.user!!),
            content = comment.content,
            creationDate = comment.creationDate,
            upvotes = comment.upvotes,
            downvotes = comment.downvotes,
        )
    }
    fun convertBulkToCommentDTO(comments: List<Comment>) : List<CommentDTO> {
        return comments.map { convertToCommentDTO(it) }
    }

    fun convertToUserDTO(user: User): UserDTO {
        return UserDTO(
            userId = user.userId,
            username = user.username,
            email = user.email,
            profilePicture = user.profilePicture,
            about = user.about,
            title = user.title,
            company = user.company,
            tags = convertBulkToTagDTO(user.tags),
            isVisible = user.isVisible
        )
    }
    fun convertBulkToUserDTO(users: List<User>): List<UserDTO> {
        return users.map { convertToUserDTO(it) }
    }

    fun convertToTagDTO(tag: Tag): TagDTO{
        return TagDTO(
            tagId = tag.tagId,
            name = tag.name
        )
    }

    fun convertBulkToTagDTO(tags: List<Tag>): List<TagDTO>{
        return tags.map{tag -> convertToTagDTO(tag)}
    }

    fun convertToLFGDTO(lfg: LFG): LFGDTO{
        return LFGDTO(
            lfg.lfgId,
            lfg.title,
            lfg.description,
            lfg.requiredPlatform,
            lfg.requiredLanguage,
            lfg.micCamRequirement,
            lfg.memberCapacity,
            lfg.creationDate,
            lfg.user,
            lfg.relatedGame?.let { convertToGameDTO(it) },
            convertBulkToTagDTO(lfg.tags)
        )
    }

    fun convertBulkToLFGDTO(lfgs: List<LFG>): List<LFGDTO>{
        return lfgs.map { lfg -> convertToLFGDTO(lfg) }
    }

    fun convertToGameDTO(game: Game): GameDTO{
        return GameDTO(
            game.gameId,
            game.title,
            game.description,
            game.genre,
            game.platform,
            convertBulkToCharacterDTO(game.characters),
            game.playerNumber,
            game.releaseYear,
            game.universe,
            game.mechanics,
            game.playtime,
            game.totalRating,
            game.countRating,
            game.averageRating,
            game.creationDate,
            convertBulkToTagDTO(game.tags),
            game.gamePicture,
            game.status.toString(),
            game.isDeleted
        )
    }

    fun convertBulkToCharacterDTO(characters: List<Character>): List<CharacterDTO>{
        return characters.map{character -> convertToCharacterDTO(character)}
    }

    fun convertToCharacterDTO(character: Character) : CharacterDTO {
        return CharacterDTO(
                characterId  = character.characterId,
                name = character.name,
                description = character.description,
                gameID = character.relatedGame?.gameId!!
        )
    }

    fun convertBulkToGameDTO(games: List<Game>): List<GameDTO>{
        return games.map { game -> convertToGameDTO(game) }
    }

    fun convertToReportDTO(report: Report): ReportDTO{
        return ReportDTO(
            report.reportId,
            report.reason,
            convertToUserDTO(report.reportingUser!!),
            report.reportedPost?.let { convertToPostDTO(it) },
            report.reportedGame?.let { convertToGameDTO(it) },
            report.reportedLFG?.let { convertToLFGDTO(it) },
            report.reportedComment?.let { convertToCommentDTO(it) }
        )
    }

    fun convertToReportDTO(reports: List<Report>): List<ReportDTO>{
        return reports.map { report -> convertToReportDTO(report) }
    }


    fun converToUserGameRatingDTO(userGameRating: UserGameRating): UserGameRatingDTO{
        return UserGameRatingDTO(
            convertToGameDTO(userGameRating.game),
            userGameRating.score
        )
    }

    fun convertBulkToUserGameRatingDTO(userGameRatings: List<UserGameRating>): List<UserGameRatingDTO>{
        return userGameRatings.map { userGameRating -> converToUserGameRatingDTO(userGameRating) }

    fun convertBulkToEditedGameDTO(editedGames: List<RequestedEditingGame>): List<EditedGameDTO>{
        return editedGames.map { editedGame -> convertToEditedGameDTO(editedGame) }
    }

    fun convertToEditedGameDTO(requestedEditingGame: RequestedEditingGame): EditedGameDTO{
        return EditedGameDTO(
                requestedEditingGame.gameId,
                requestedEditingGame.title,
                requestedEditingGame.description,
                requestedEditingGame.genre,
                requestedEditingGame.platform,
                requestedEditingGame.playerNumber,
                requestedEditingGame.releaseYear,
                requestedEditingGame.universe,
                requestedEditingGame.mechanics,
                requestedEditingGame.playtime,
                requestedEditingGame.creationDate,
                requestedEditingGame.gamePicture,
        )

    }
}