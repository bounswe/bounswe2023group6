import React from 'react';

const Group = ({ item }) => {
    return (
        <div className="card compact bg-green-100 text-sky-800 shadow-xl m-2">
            <figure className="px-4 pt-4">
                <img src={item.image} alt="Group" className="rounded-lg h-20 w-20 object-cover" />
            </figure>
            <div className="card-body">
                <h2 className="card-title text-base">{item.header}</h2>
                <p className="text-xs">{item.text}</p>
                <div className="flex justify-between items-center text-xs">
                    <span>Players: {item.players}</span>
                    <button className="btn btn-secondary btn-sm">Join</button>
                </div>
            </div>
        </div>
    );
}

export default Group;
