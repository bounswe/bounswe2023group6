import React from 'react';

const LikedPosts = ({ item }) => {
    return (
        <div className="card bg-[#FFF4E0] text-sky-800 shadow-xl m-2 w-full">
            <div className="card-body">
                <h2 className="card-title text-base">{item.header}</h2>
                <p className="text-xs">{item.content}</p>
                <div className="card-actions justify-end">
                    <button className="btn btn-circle btn-sm btn-secondary bg-[#B46060] hover:bg-[#B46060] ">
                        <i className="i pi pi-thumbs-up" />
                    </button>
                    <button className="btn btn-circle btn-sm btn-secondary bg-[#B46060] hover:bg-[#B46060]">
                        <i className="i pi pi-thumbs-down" />
                    </button>
                </div>
            </div>
        </div>
    );
}

export default LikedPosts;
