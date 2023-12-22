import { useState, useEffect } from 'react';
import { getAllGames, createEditingRequest } from '../../services/gameService';
import Navbarx from '../../components/navbar/Navbar';

const AdminPanel = () => {
  const [games, setGames] = useState([]);

  useEffect(() => {
    const fetchGames = async () => {
      try {
        const response = await getAllGames();
        setGames(response.data);
      } catch (error) {
        console.error(error);
      }
    };
    fetchGames();
  }, []);

  const handleApprove = async (gameId) => {
    if (!window.confirm('Are you sure you want to approve this game?')) return;
    const updatedGames = games.map(game =>
      game.gameId === gameId ? { ...game, status: 'APPROVED' } : game
    );
    setGames(updatedGames);
    // Implement API call to approve the game here if needed
  };

  const handleSave = async (gameId) => {
    const game = games.find(game => game.gameId === gameId);
    try {
      await createEditingRequest(gameId, game);
      console.log('Game updated successfully!');
    } catch (error) {
      console.error(error);
    }
  };

  return (
    <>
      <Navbarx></Navbarx>
      <div className="overflow-x-auto">
        <table className="min-w-full table-auto">
          <thead className="bg-gray-200">
            <tr>
              <th className="px-4 py-2">Title</th>
              <th className="px-4 py-2">Status</th>
              <th className="px-4 py-2">Approve</th>
              <th className="px-4 py-2">Save</th>
            </tr>
          </thead>
          <tbody>
            {games.map(game => (
              <tr key={game.gameId} className="text-center">
                <td className="border px-4 py-2">{game.title}</td>
                <td className="border px-4 py-2">
                  <span className={`px-2 inline-flex text-xs leading-5 font-semibold rounded-full ${game.status === 'APPROVED' ? 'bg-green-100 text-green-800' : 'bg-yellow-100 text-yellow-800'}`}>
                    {game.status.replace('_', ' ')}
                  </span>
                </td>
                <td className="border px-4 py-2">
                  <label className="switch">
                    <input
                      type="checkbox"
                      checked={game.status === 'APPROVED'}
                      onChange={() => handleApprove(game.gameId)}
                      className="form-checkbox h-5 w-5 text-blue-600"
                    />
                    <span className="slider round"></span>
                  </label>
                </td>
                <td className="border px-4 py-2">
                  <button onClick={() => handleSave(game.gameId)} className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
                    Save
                  </button>
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
