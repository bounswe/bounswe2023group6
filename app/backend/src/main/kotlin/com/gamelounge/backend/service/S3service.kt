package com.gamelounge.backend.service

import com.gamelounge.backend.constant.S3Constants.EDITED_GAME_PICTURE_DIRECTORY
import com.gamelounge.backend.constant.S3Constants.GAME_PICTURE_DIRECTORY
import com.gamelounge.backend.constant.S3Constants.PROFILE_PICTURE_DIRECTORY
import org.springframework.beans.factory.annotation.Value
import org.springframework.stereotype.Service
import org.springframework.web.multipart.MultipartFile
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials
import software.amazon.awssdk.core.sync.RequestBody
import software.amazon.awssdk.regions.Region
import software.amazon.awssdk.services.s3.S3Client
import software.amazon.awssdk.services.s3.model.PutObjectRequest
import software.amazon.awssdk.services.s3.model.PutObjectResponse
import java.io.InputStream


@Service
class S3Service(
    @Value("\${cloud.aws.s3.bucket}") private val bucketName: String,
    @Value("\${cloud.aws.credentials.accessKey}") private val accessKey: String,
    @Value("\${cloud.aws.credentials.secretKey}") private val secretKey: String
) {

    fun uploadProfilePictureAndReturnURL(image: MultipartFile, userId: Long): String{
        val s3 = createS3Client()

        putImageToS3Bucket(s3, image, "profile-pictures/$userId")

        return createProfilePictureURL(userId)
    }

    fun uploadGamePictureAndReturnURL(image: MultipartFile, gameId: Long): String{
        val s3 = createS3Client()

        putImageToS3Bucket(s3, image, "game-pictures/$gameId")

        return createGamePicturesURL(gameId)
    }

    fun uploadEditedGamePictureAndReturnURL(editedImage: MultipartFile, gameId: Long): String{
        val s3 = createS3Client()

        putImageToS3Bucket(s3, editedImage, "edited-game-pictures/$gameId")

        return createEditedGamePicturesURL(gameId)
    }

    private fun createS3Client(): S3Client{
        return S3Client.builder()
            .region(Region.EU_NORTH_1)
            .credentialsProvider { AwsBasicCredentials.create(accessKey, secretKey) }
            .build()
    }

    private fun putImageToS3Bucket(s3: S3Client, imageData: MultipartFile, key: String){
        val imageStream: InputStream = imageData.inputStream

        val putObjectRequest = PutObjectRequest.builder()
            .bucket(bucketName)
            .key(key)
            .contentType(imageData.contentType)
            .build()

        s3.putObject(putObjectRequest, RequestBody.fromInputStream(imageStream, imageData.size))

    }

    private fun createProfilePictureURL(userId: Long): String{
        return PROFILE_PICTURE_DIRECTORY + userId
    }

    private fun createGamePicturesURL(gameId: Long): String{
        return GAME_PICTURE_DIRECTORY + gameId
    }

    private fun createEditedGamePicturesURL(gameId: Long): String{
        return EDITED_GAME_PICTURE_DIRECTORY + gameId
    }
}