import axios from 'axios'

const axiosInstance = axios.create({
	baseURL: process.env.REACT_APP_API_URL
})

axiosInstance.defaults.withCredentials = true

export const getAllGroups = () => {
	return axiosInstance.get('/lfg/all')
}

export const createLfg = (lfgData) => {
	return axiosInstance.post('/lfg', lfgData, {
		withCredentials: true
	})
}

export const getGroupById = (lfgId) => {
	return axiosInstance.get(`/lfg/${lfgId}`)
}

export const updateLfg = (lfgId, lfgData, sessionId) => {
	return axiosInstance.put(`/lfg/${lfgId}`, lfgData, {
		headers: { Cookie: `SESSIONID=${sessionId}` }
	})
}

export const deleteLfg = (lfgId, sessionId) => {
	return axiosInstance.delete(`/lfg/${lfgId}`, {
		headers: { Cookie: `SESSIONID=${sessionId}` }
	})
}

export const getRecommendedGroups = () => {
	return axiosInstance.get('/lfg/recommended')
}
