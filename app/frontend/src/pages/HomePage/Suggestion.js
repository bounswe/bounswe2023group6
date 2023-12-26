import React from 'react'
const username = localStorage.getItem('username')

const Suggestion = ({ item }) => {
	return (
		// TODO: Fix repsponsive design
		<div className='card compact bg-neutral-200 text-cyan-700 shadow-xl m-2'>
			<figure className='px-4 pt-4'>
				<img src={item.image} alt={item.username} className='rounded-full h-20 w-20 object-cover' />
			</figure>
			<div className='card-body items-center text-center'>
				<h2 className='card-title text-base'>{item.username}</h2>
				<p className='text-xs text-neutral-700'>{item.tag}</p>
				{username ? (
					<div className='card-actions'>
						<button className='btn bg-[#b46161] border-[#b46161] text-neutral-100 hover:bg-[#8c4646] hover:border-[#8c4646] btn-sm'>
							Follow
						</button>
					</div>
				) : (
					<></>
				)}
			</div>
		</div>
	)
}

export default Suggestion
