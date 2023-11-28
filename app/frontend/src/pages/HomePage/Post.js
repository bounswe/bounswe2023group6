import React from 'react';
import { Link } from 'react-router-dom';

const Post = ({ post }) => {
    return (
        <div className="card compact bg-gray-200 text-gray-800 shadow-xl m-2">
            <figure className="px-4 pt-4">
                <img src={post.creatorUser.profilePicture} alt="Post" className="rounded-lg h-20 w-20 object-cover" />
            </figure>
            <div className="card-body">
                <h2 className="card-title text-gray-700">
                    <Link to={`/posts/${post.postId}`}>
                        {post.title}
                    </Link>
                </h2>
                <p className="text-xs">{post.content}</p>
                <div className="card-actions justify-end">
                    <button className="btn btn-circle btn-sm bg-[#b46161] border-[#b46161] text-gray-100 hover:bg-[#8c4646] hover:border-[#8c4646]">
                        <i className="i pi pi-thumbs-up" />
                    </button>
                    <button className="btn btn-circle btn-sm bg-[#b46161] border-[#b46161] text-gray-100 hover:bg-[#8c4646] hover:border-[#8c4646]">
                        <i className="i pi pi-thumbs-down" />
                    </button>
                </div>
            </div>
        </div>
    );
}

export default Post;
