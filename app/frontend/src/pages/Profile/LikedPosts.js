import React from 'react';

const LikedPosts = ({ item }) => {
    return (
        <div className="card bg-gray-300 text-cyan-800 shadow-xl m-2 w-full">
            <div className="card-body">
                <h2 className="card-title text-base">{item.header}</h2>
                <p className="text-xs text-gray-700">{item.content}</p>
                <div className="card-actions justify-end">
                    <button className="btn btn-circle btn-sm bg-[#B46060] border-[#b46161] hover:bg-[#7d3e3e] text-gray-200">
                        <i className="i pi pi-thumbs-up" />
                    </button>
                    <button className="btn btn-circle btn-sm bg-[#B46060] border-[#b46161] hover:bg-[#7d3e3e] text-gray-200">
                        <i className="i pi pi-thumbs-down" />
                    </button>
                </div>
            </div>
        </div>
    );
}

export default LikedPosts;
