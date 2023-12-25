import axios from 'axios'

const axiosInstance = axios.create({
	baseURL: process.env.REACT_APP_API_URL
})

axiosInstance.defaults.withCredentials = true

export const getUserInfoBySessionId = () => {
	return axiosInstance.get(
		'/user',
		{},
		{
			withCredentials: true,
			headers: { 'Content-Type': 'application/json' }
		}
	)
}

export const updateUserByUserId = (sessionId, userData) => {
	return axiosInstance.post('/user', userData, {
		headers: { Cookie: `SESSIONID=${sessionId}` }
	})
}

export const getUserInfoByUsername = (username) => {
	return axiosInstance.get(`/user/${username}`)
}

export const getLikedPosts = (sessionId) => {
	return axiosInstance.get('/user/liked-posts', {
		headers: { Cookie: `SESSIONID=${sessionId}` }
	})
}

export const getLikedComments = (sessionId) => {
	return axiosInstance.get('/user/liked-comments', {
		headers: { Cookie: `SESSIONID=${sessionId}` }
	})
}

export const getCreatedPosts = (sessionId) => {
	return axiosInstance.get('/user/created-posts', {
		headers: { Cookie: `SESSIONID=${sessionId}` }
	})
}

export const getCreatedGames = (sessionId) => {
	return axiosInstance.get('/user/created-games', {
		headers: { Cookie: `SESSIONID=${sessionId}` }
	})
}

export const getLikedCommentsByUserId = (userId) => {
	return axiosInstance.get(`/user/liked-comments/${userId}`)
}

export const getLikedPostsByUserId = (userId) => {
	return axiosInstance.get(`/user/liked-posts/${userId}`)
}

export const getCreatedPostsByUserId = (userId) => {
	return axiosInstance.get(`/user/created-posts/${userId}`)
}
