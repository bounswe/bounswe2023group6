import React from 'react';

const Group = ({ item }) => {
    return (
        <div className="card compact bg-gray-200 text-gray-800 shadow-xl m-2">
            <figure className="px-4 pt-4">
                <img src={item.image} alt="Group" className="rounded-lg h-20 w-20 object-cover" />
            </figure>
            <div className="card-body">
                <h2 className="card-title text-gray-700">{item.header}</h2>
                <p className="text-xs">{item.text}</p>
                <div className="flex justify-between items-center text-xs">
                    <span>Players: {item.players}</span>
                    <button className="btn bg-[#b46161] border-[#b46161] text-gray-100 hover:bg-[#8c4646] hover:border-[#8c4646] btn-sm">Join</button>
                </div>
            </div>
        </div>
    );
}

export default Group;
