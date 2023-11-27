import axios from 'axios'

const axiosInstance = axios.create({
	baseURL: 'http://localhost:8080'
})

export const getGame = (gameId) => {
	return axiosInstance.get(`/game/${gameId}`)
}

export const editGame = (gameID, gameData, sessionId) => {
	return axiosInstance.put(`/games/${gameID}`, gameData, {
		headers: { Cookie: `SESSIONID=${sessionId}` }
	})
}

export const rateGame = (gameID, rateData, sessionId) => {
	return axiosInstance.put(`/game/${gameID}/rating/${rateData}`, rateData, {
		headers: { Cookie: `SESSIONID=${sessionId}` }
	})
}
