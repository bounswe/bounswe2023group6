import axios from 'axios'

const axiosInstance = axios.create({
    baseURL: process.env.REACT_APP_API_URL
})
axiosInstance.defaults.withCredentials = true

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
		headers: { Cookie: `SESSIONID=${sessionId}`, withCredentials: true }
	})
}
export const postChar = (gameID, chardata, sessionId) => {
	return axiosInstance.post(`/character/${gameID}`, {
		headers: { Cookie: `SESSIONID=${sessionId}` }
	})
}
