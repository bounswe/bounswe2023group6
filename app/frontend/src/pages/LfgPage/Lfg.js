import React, { useState, useEffect } from 'react';
import Navbarx from '../../components/navbar/Navbar';
import CommentCard from '../../components/CommentCard';
import { getGroupById } from '../../services/lfgService';
import { useParams } from 'react-router-dom';
import {getAllCommentsForLfg, createCommentForLfg} from '../../services/commentService';
import { upvoteComment, downvoteComment } from '../../services/commentService';
import { getUserInfoBySessionId } from '../../services/userService';
import LfgCard from "./LfgCard";

const Lfg = () => {
    const { lfgId } = useParams();
    console.log(lfgId);

    const [lfg, setLfg] = useState(null);
    const [comments, setComments] = useState([]);
    const [currentUser, setCurrentUser] = useState(null);


    const handleUpvoteComment = async (commentId) => {
        try {
            const response = await upvoteComment(commentId);
            setComments(comments.map(comment => comment.commentId === commentId ? response.data : comment));
        } catch (error) {
            console.error("Error upvoting comment:", error);
        }
    };

    const handleDownvoteComment = async (commentId) => {
        try {
            const response = await downvoteComment(commentId);
            setComments(comments.map(comment => comment.commentId === commentId ? response.data : comment));
        } catch (error) {
            console.error("Error downvoting comment:", error);
        }
    };

    useEffect(() => {
        const fetchLfgAndComments = async () => {
            try {
                const lfgResponse = await getGroupById(lfgId);
                setLfg(lfgResponse.data);

                const commentsResponse = await getAllCommentsForLfg(lfgId);
                setComments(commentsResponse.data);
            } catch (error) {
                console.error("Error getting lfg and comments:", error);
            }
        };

        if (lfgId) {
            fetchLfgAndComments();
        }
    }, [lfgId]);

    useEffect(() => {
        const fetchUserInfo = async () => {
            try {
                const response = await getUserInfoBySessionId();
                const userData = response.data;
                setCurrentUser(userData);
                console.log('Current User:', userData);
            } catch (error) {
                console.error('Error fetching user info:', error);
            }
        };
        fetchUserInfo();
    }, []);

    const [newComment, setNewComment] = useState('');

    const handleNewComment = async (e) => {
        e.preventDefault();
        try {
            const response = await createCommentForLfg(lfgId, { content: newComment }, null);
            setComments([...comments, response.data]);
            setNewComment('');
        } catch (error) {
            console.error("Error creating comment:", error);
        }
    };

    return (
        <>
            <Navbarx />
            <div className='w-full flex flex-col bg-neutral-100 items-center pt-8'>
                <div className='w-3/4 flex flex-col p-2 pb-20'>
                    {lfg && (
                        <LfgCard group={lfg} currentUser={currentUser}/>
                    )}
                    <div className='mt-6'>
                        {comments.map((comment) => (
                            <CommentCard
                                key={comment.commentId}
                                comment={comment}
                                onUpvote={() => handleUpvoteComment(comment.commentId)}
                                onDownvote={() => handleDownvoteComment(comment.commentId)}
                                currentUser={currentUser}
                            />
                        ))}
                    </div>
                    <textarea
                        className='w-full h-24 p-2 border-2 border-gray-300 rounded-lg shadow-md focus:outline-none focus:border-gray-500'
                        placeholder='Add a comment...'
                        value={newComment}
                        onChange={(e) => setNewComment(e.target.value)}
                    ></textarea>
                    <div className='pt-4'>
                        <button
                            className='w-20 h-10 p-2 bg-cyan-700 text-white rounded-lg shadow-md hover:bg-cyan-900 focus:outline-none'
                            onClick={handleNewComment}
                        >Send</button>
                    </div>
                </div>
            </div>
            <div className='bg-black text-white text-center p-8'>
                <p className='text-m'>@2023 Game Lounge, All rights reserved.</p>
            </div>
        </>
    );
};

export default Lfg;
