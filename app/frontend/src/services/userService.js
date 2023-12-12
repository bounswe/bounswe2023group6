import axios from 'axios';

const axiosInstance = axios.create({
  baseURL: process.env.REACT_APP_API_URL
});

axiosInstance.defaults.withCredentials = true;

export const getUserInfoBySessionId = (sessionId) => {
  return axiosInstance.get('/user', {
    headers: { Cookie: `SESSIONID=${sessionId}` },
    withCredentials: true
  });
};

export const updateUserByUserId = (sessionId, userData) => {
  return axiosInstance.post('/user', userData, {
    headers: { Cookie: `SESSIONID=${sessionId}` },
    withCredentials: true
  });
};

export const getUserInfoByUsername = (username) => {
  return axiosInstance.get(`/user/${username}`);
};

export const getLikedPosts = (sessionId) => {
  return axiosInstance.get('/user/liked-posts', {
    headers: { Cookie: `SESSIONID=${sessionId}` },
    withCredentials: true
  });
};

export const getLikedComments = (sessionId) => {
  return axiosInstance.get('/user/liked-comments', {
    headers: { Cookie: `SESSIONID=${sessionId}` },
    withCredentials: true
  });
};

export const getCreatedPosts = (sessionId) => {
  return axiosInstance.get('/user/created-posts', {
    headers: { Cookie: `SESSIONID=${sessionId}` },
    withCredentials: true
  });
};

export const getCreatedGames = (sessionId) => {
  return axiosInstance.get('/user/created-games', {
    headers: { Cookie: `SESSIONID=${sessionId}` },
    withCredentials: true
  });
};

export const getRatedGames = (sessionId) => {
  return axiosInstance.get('/game/rated', {
    headers: { Cookie: `SESSIONID=${sessionId}` },
    withCredentials: true
  });
};