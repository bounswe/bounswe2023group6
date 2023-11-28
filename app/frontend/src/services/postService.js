import axios from 'axios';

const axiosInstance = axios.create({
  baseURL: process.env.REACT_APP_API_URL
});

axiosInstance.defaults.withCredentials = true;

export const getAllPosts = () => {
  return axiosInstance.get('/forum/posts');
};

export const createPost = (postData) => {
  console.log(postData);
  return axiosInstance.post('/forum/posts', postData, {
    withCredentials: true
  });
};

export const getPostById = (postId) => {
  return axiosInstance.get(`/forum/posts/${postId}`);
};

export const updatePost = (postId, postData, sessionId) => {
  return axiosInstance.put(`/forum/posts/${postId}`, postData, {
    headers: { Cookie: `SESSIONID=${sessionId}` }
  });
};

export const deletePost = (postId, sessionId) => {
  return axiosInstance.delete(`/forum/posts/${postId}`, {
    headers: { Cookie: `SESSIONID=${sessionId}` }
  });
};

export const upvotePost = (postId, sessionId) => {
  return axiosInstance.put(`/forum/posts/${postId}/upvote`, {}, {
    headers: { Cookie: `SESSIONID=${sessionId}` }
  });
};

export const downvotePost = (postId, sessionId) => {
  return axiosInstance.put(`/forum/posts/${postId}/downvote`, {}, {
    headers: { Cookie: `SESSIONID=${sessionId}` }
  });
};

export const reportPost = (postId, reportData, sessionId) => {
  return axiosInstance.post(`/forum/posts/${postId}/report`, reportData, {
    headers: { Cookie: `SESSIONID=${sessionId}` }
  });
};
