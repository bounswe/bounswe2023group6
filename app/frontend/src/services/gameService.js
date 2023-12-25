import axios from 'axios'

const axiosInstance = axios.create({
	baseURL: process.env.REACT_APP_API_URL
})

axiosInstance.defaults.withCredentials = true

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

export const getPendingGames = () => {
	return axiosInstance.get('/admin/pendingGames', {
		withCredentials: true
	})
}

export const getEditedGames = () => {
	return axiosInstance.get('/admin/editedGames', {
		withCredentials: true
	})
}

export const approveEditingGame = (editingGameId) => {
	return axiosInstance.put(
		`/admin/approveEditingGame/${editingGameId}`,
		{},
		{
			withCredentials: true,
			headers: { 'Content-Type': 'application/json' }
		}
	)
}

export const rejectEditingGame = (editingGameId) => {
	return axiosInstance.put(
		`/admin/rejectEditingGame/${editingGameId}`,
		{},
		{
			withCredentials: true,
			headers: { 'Content-Type': 'application/json' }
		}
	)
}

export const approveGame = (gameId) => {
	return axiosInstance.put(
		`/admin/approveGame/${gameId}`,
		{},
		{
			withCredentials: true,
			headers: { 'Content-Type': 'application/json' }
		}
	)
}

export const rejectGame = (gameId) => {
	return axiosInstance.put(
		`/admin/rejectGame/${gameId}`,
		{},
		{
			withCredentials: true,
			headers: { 'Content-Type': 'application/json' }
		}
	)
}
