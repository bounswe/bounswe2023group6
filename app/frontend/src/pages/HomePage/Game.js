import React from 'react';

const Game = ({ item }) => {
    return (
        <div className="card compact bg-green-100 text-sky-800 shadow-xl m-2">
            <figure className="px-4 pt-4">
                <img src={item.image} alt="Post" className="rounded-lg h-20 w-20 object-cover" />
            </figure>
            <div className="card-body">
                <h2 className="card-title text-base">{item.title}</h2>
                <p className="text-xs">{item.content}</p>
            </div>
        </div>
    );
}

export default Game;
