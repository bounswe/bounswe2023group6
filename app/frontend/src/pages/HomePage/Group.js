import React from 'react';
import { Link } from 'react-router-dom';
import profileIcon from "./profile.jpg";

const Group = ({ group }) => {
    return (
                   <div className="card compact bg-neutral-200 text-neutral-800 shadow-xl m-2">
                   <figure className="px-4 pt-4">
                                   <img src={group.user.profilePicture || profileIcon} alt="Post" className="rounded-lg h-20 w-20 object-cover" onError={(e) => {
                                      e.target.src = profileIcon;
                                      }}/>
                               </figure>
                       <div className="card-body">
                           <h2 className="card-title text-neutral-700">
                               <Link to={`/lfg/${group.lfgId}`}>
                                   {group.title}
                               </Link>
                           </h2>
                           <p >Game: {group.relatedGame}</p>
                           <p >Language: {group.requiredLanguage}</p>
                           <p >Platform: {group.requiredPlatform}</p>
                           <div className="card-actions justify-end">
                            <button className="btn bg-[#b46161] border-[#b46161] text-neutral-100 hover:bg-[#8c4646] hover:border-[#8c4646] btn-sm">Join</button>
                           </div>
                       </div>
                   </div>
               );
           }

           export default Group;
