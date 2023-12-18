import React from 'react';

const Post = ({ game }) => {
    return (
        <div className="card compact bg-neutral-200 text-neutral-800 shadow-xl m-2">
            <figure className="px-4 pt-4">
                <img src={game.gamePicture} alt="Post" className="rounded-lg h-20 w-20 object-cover" />
            </figure>
            <div className="card-body">
                <h2 className="card-title text-neutral-700 text-base">
                        <a href={`/game/${game.gameId}`}>{game.title}</a>
                </h2>
                <p className="text-xs">{game.description}</p>
                <div className="card-actions justify-end">
                    <button className="btn btn-circle btn-sm bg-[#b46161] border-[#b46161] text-neutral-100 hover:bg-[#8c4646] hover:border-[#8c4646]">
                        <i className="i pi pi-thumbs-up" />
                    </button>
                    <button className="btn btn-circle btn-sm bg-[#b46161] border-[#b46161] text-neutral-100 hover:bg-[#8c4646] hover:border-[#8c4646]">
                        <i className="i pi pi-thumbs-down" />
                    </button>
                </div>
            </div>
        </div>
    );
}

export default Post;
