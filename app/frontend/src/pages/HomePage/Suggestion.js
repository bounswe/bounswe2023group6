import React from 'react';

const Suggestion = ({ item }) => {
    return ( // TODO: Fix repsponsive design
        <div className="card compact bg-green-100 text-sky-800 shadow-xl m-2">
            <figure className="px-4 pt-4">
                <img src={item.image} alt={item.username} className="rounded-full h-20 w-20 object-cover" />
            </figure> 
            <div className="card-body items-center text-center">
                <h2 className="card-title text-base">{item.username}</h2>
                <p className="text-xs">{item.tag}</p>
                <div className="card-actions">
                    <button className="btn btn-secondary btn-sm">Follow</button>
                </div>
            </div>
        </div>
    );
};

export default Suggestion;
