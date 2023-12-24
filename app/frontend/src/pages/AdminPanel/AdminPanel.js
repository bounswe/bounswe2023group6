import { useState, useEffect } from 'react';
import { getPendingGames, getEditedGames, approveGame, rejectGame } from '../../services/gameService';
import Navbarx from '../../components/navbar/Navbar';

const AdminPanel = () => {
  const [games, setGames] = useState([]);

  useEffect(() => {
    const fetchGames = async () => {
      try {
        const pendingResponse = await getPendingGames();
        const editedResponse = await getEditedGames();
        const allGames = [...pendingResponse.data, ...editedResponse.data];
        const uniqueGames = Array.from(new Map(allGames.map(game => [game.gameId, game])).values());
        setGames(uniqueGames);
      } catch (error) {
        console.error(error);
      }
    };
    fetchGames();
  }, []);

  const handleApprove = async (gameId) => {
    if (!window.confirm('Are you sure you want to approve this game?')) return;
    try {
      await approveGame(gameId);
      setGames(games.map(game => game.gameId === gameId ? { ...game, status: 'APPROVED' } : game));
    } catch (error) {
      console.error(error);
    }
  };

  const handleReject = async (gameId) => {
    if (!window.confirm('Are you sure you want to reject this game?')) return;
    try {
      await rejectGame(gameId);
      setGames(games.map(game => game.gameId === gameId ? { ...game, status: 'REJECTED' } : game));
    } catch (error) {
      console.error(error);
    }
  };

  return (
    <>
      <Navbarx />
      <div className="overflow-x-auto">
        <table className="min-w-full table-auto">
          <thead className="bg-gray-200">
            <tr>
              <th className="px-4 py-2">Title</th>
              <th className="px-4 py-2">Details</th>
              <th className="px-4 py-2">Status</th>
              <th className="px-4 py-2">Actions</th>
            </tr>
          </thead>
          <tbody>
            {games.map(game => (
              <tr key={game.gameId} className="text-center">
                <td className="border px-4 py-2">{game.title}</td>
                <td className="border px-4 py-2 justify-center items-center">
                  <div>Description: {game.description}</div>
                  <div>Player Number: {game.playerNumber}</div>
                  <div>Release Year: {game.releaseYear}</div>
                  <div>Genre: {game.genre}</div>
                  <div>Platform: {game.platform}</div>
                  <div>Universe: {game.universe}</div>
                  <div>Mechanics: {game.mechanics}</div>
                  <div>Playtime: {game.playtime}</div>
                </td>
                <td className="border px-4 py-2">
                  <span className={`px-2 inline-flex text-xs leading-5 font-semibold rounded-full ${game.status ? (game.status === 'APPROVED' ? 'bg-green-100 text-green-800' : game.status === 'REJECTED' ? 'bg-red-100 text-red-800' : 'bg-yellow-100 text-yellow-800') : 'bg-green-100 text-green-800'}`}>
                    {game.status ? game.status.replace('_', ' ') : 'APPROVED'}
                  </span>
                </td>
                <td className="border px-4 py-2">
                  {game.status === 'PENDING_APPROVAL' && (
                    <>
                      <button onClick={() => handleApprove(game.gameId)} className="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded mr-2">
                        Approve
                      </button>
                      <button onClick={() => handleReject(game.gameId)} className="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded">
                        Reject
                      </button>
                    </>
                  )}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </>
  );
};

export default AdminPanel;
