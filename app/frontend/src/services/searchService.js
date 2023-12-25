import axios from 'axios'

const axiosInstance = axios.create({
	baseURL: process.env.REACT_APP_API_URL
})

axiosInstance.defaults.withCredentials = true

export const getAllSearch = (search) => {
	const url = `/search/all?query=${search}`
	return axiosInstance.get(url, {
		withCredentials: true
	})
}
