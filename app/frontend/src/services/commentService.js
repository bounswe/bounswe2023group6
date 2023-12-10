import axios from 'axios';


const axiosInstance = axios.create({
    baseURL: process.env.REACT_APP_API_URL
});

axiosInstance.defaults.withCredentials = true;

export const getAllCommentsForPost = (postId) => {
    return axiosInstance.get(`/comments/post/${postId}`);
};

export const createComment = (postId, commentData, sessionId) => {
    return axiosInstance.post(`/comments/post/${postId}`, commentData, {
        headers: { Cookie: `SESSIONID=${sessionId}` }
    });
};

export const getCommentById = (commentId) => {
    return axiosInstance.get(`/comments/${commentId}`);
};

export const updateComment = (commentId, commentData, sessionId) => {
    return axiosInstance.put(`/comments/${commentId}`, commentData, {
        headers: { Cookie: `SESSIONID=${sessionId}` }
    });
};

export const deleteComment = (commentId, sessionId) => {
    return axiosInstance.delete(`/comments/${commentId}`, {
        headers: { Cookie: `SESSIONID=${sessionId}` }
    });
};

export const upvoteComment = (commentId, sessionId) => {
    return axiosInstance.put(`/comments/${commentId}/upvote`, {}, {
        headers: { Cookie: `SESSIONID=${sessionId}` }
    });
};

export const downvoteComment = (commentId, sessionId) => {
    return axiosInstance.put(`/comments/${commentId}/downvote`, {}, {
        headers: { Cookie: `SESSIONID=${sessionId}` }
    });
};

export const reportComment = (commentId, reportData, sessionId) => {
    return axiosInstance.post(`/comments/${commentId}/report`, reportData, {
        headers: { Cookie: `SESSIONID=${sessionId}` }
    });
};
