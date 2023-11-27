import React from 'react'

const GameCard = ({ game }) => (
	<div key={game.gameId} className='card compact bg-gray-200 text-gray-800 shadow-xl m-2 p-4'>
		<div className='flex-col'>
			<h3 className='text-2xl font-bold text-[#b46161] link'>
				<a href={`/game/${game.gameId}`}>{game.title}</a>
			</h3>
			<p className='text-gray-700 mb-4'>{game.description}</p>
			<div className='flex flex-wrap border-b-2 border-gray-200 pb-2 opacity-75 mb-4'>
				{/* {game.tags.map((tag) => (
          <span key={tag.tagId} className='badge badge-secondary mr-2'>#{tag.name}</span>
        ))} */}
			</div>
			<div className='flex justify-between items-center'>
				<div className='flex items-center'>
					<div className='avatar'>
						<div className='w-12 h-12 rounded-full'>
							{/* Assuming gamePicture is a URL */}
							<img src={game.gamePicture} alt='Game' />
						</div>
					</div>
				</div>
				<div className='flex'>
					<div className='mr-12'>{game.platform}</div>
					<div className='mr-12'>{game.genre}</div>
				</div>
			</div>
		</div>
	</div>
)

export default GameCard
