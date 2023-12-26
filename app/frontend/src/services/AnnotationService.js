import axios from 'axios'

const axiosInstance = axios.create({
	// baseURL: process.env.REACT_APP_API_URL
	baseURL: 'https://game-lounge.com:9091'
})

axiosInstance.defaults.withCredentials = true

export const createAnnotation = (annotationData) => {
	return axiosInstance.post('/annotation/create', annotationData, {
		withCredentials: true
	})
}

export const getAnnotationsByTarget = (targetId) => {
	return axiosInstance.post(
		'/annotation/get-annotations-by-target',
		{ targetId },
		{
			withCredentials: true
		}
	)
}
