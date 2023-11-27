import axios from 'axios'

const axiosInstance = axios.create({
	baseURL: 'http://127.0.0.1:8080'
})

export const createGame = (gameData, imageData) => {
	const formData = new FormData()
	formData.append('request', JSON.stringify(gameData))
	formData.append('image', imageData)
	return axiosInstance.post('/game', formData, {
		headers: { 'Content-Type': 'multipart/form-data' }
	})
}

export const getGame = (gameId) => {
	return axiosInstance.get(`/game/${gameId}`)
}

export const updateGame = (gameId, updatedGameData) => {
	return axiosInstance.put(`/game/${gameId}`, updatedGameData)
}

export const deleteGame = (gameId) => {
	return axiosInstance.delete(`/game/${gameId}`)
}

export const getAllGames = () => {
	return axiosInstance.get('/game')
}

export const rateGame = (gameId, score) => {
	return axiosInstance.put(`/game/${gameId}/rating/${score}`)
}
