import React, {useEffect, useState} from 'react'
import {
    Dialog,
    DialogTitle,
    DialogContent,
    TextField,
    DialogActions,
    Button,
    IconButton,
    MenuItem,
    FormControl,
    Select,
    InputLabel,
    Chip,
    Input
} from '@mui/material'
import CloseIcon from '@mui/icons-material/Close'
import { useForm } from 'react-hook-form'
import axios from 'axios'
import FormControlLabel from "@mui/material/FormControlLabel";
import Checkbox from "@mui/material/Checkbox";
import {getAllGames} from "../../services/gameService";
import EditIcon from "@mui/icons-material/Edit";

export default function EditLfg(props) {
    const [open, setOpen] = useState(false)
    const { handleSubmit } = useForm()
    const [title, setTitle] = useState(props.lfg.title)
    const [description, setDescription] = useState(props.lfg.description)
    const [requiredPlatform, setRequiredPlatform] = useState(props.lfg.requiredPlatform)
    const [requiredLanguage, setRequiredLanguage] = useState(props.lfg.requiredLanguage)
    const [micCamRequirement , setMicCamRequirement] = useState(props.lfg.micCamRequirement);
    const [memberCapacity, setmemberCapacity] = useState(props.lfg.memberCapacity)
//    const [gameId, setGameId] = useState(false)
    const [tags, setTags] = useState([]);
    const [currTag, setCurrTag] = useState("");
//    const [games, setGames] = useState([]);

    const axiosInstance = axios.create({
        baseURL: `${process.env.REACT_APP_API_URL}`
    })

    const handleClickOpen = () => {
        setOpen(true)
        console.log(props.lfg)
        console.log(props.lfg.title)
    }

    const handleClose = () => {
        setOpen(false)
    }

    const onSubmit = () => {
        axiosInstance.defaults.withCredentials = true;
        axiosInstance.put(`/lfg/${props.lfg.lfgId}`, {
            title,
            description,
            requiredPlatform,
            requiredLanguage,
            micCamRequirement,
            memberCapacity,
            tags: tags
        }, {
            withCredentials: true
        })
            .then((response) => {
                console.log(response);
                if (response.status === 200) {
                    handleClose();
                }
                window.location.reload();
            })
            .catch((error) => {
                console.log(error);
            });
    };

    useEffect(() => {
        setTitle(props.lfg.title);
        setDescription(props.lfg.description);
        setRequiredPlatform(props.lfg.requiredPlatform);
        setRequiredLanguage(props.lfg.requiredLanguage);
        setMicCamRequirement(props.lfg.micCamRequirement);
        setmemberCapacity(props.lfg.memberCapacity);
    }, [props.lfg]);

    const handleChange = (e) => {
        setCurrTag(e.target.value);
    };

    const handleDeleteTag = (item, index) => {
        let arr = [...tags];
        arr.splice(index, 1);
        console.log(item);
        setTags(arr);
    };

    const handleKeyUp = (e) => {
        if (e.keyCode === 13) {
            setTags((oldState) => [...oldState, e.target.value]);
            setCurrTag("");
        }
    };

    const handleCheckboxChange = () => {
        setMicCamRequirement(!micCamRequirement);
    };

    useEffect(() => {
        const fetchGames = async () => {
            try {
                const response = await getAllGames();
                console.log(response)
                //setGames(response.data)
            } catch (error) {
                console.error(error);
            }
        }

        fetchGames();
    }, []);

    const languages = ['TUR', 'EN']
    const platforms = ["XBOX", "COMPUTER", "PS", "ONBOARD", "EMPTY"]

    return (
        <div>
            <Button onClick={handleClickOpen}>
                <EditIcon sx={{ color: '#404040'}} />
            </Button>
            <Dialog open={open} onClose={handleClose}>
                <DialogTitle>
                    Create Lfg
                    <IconButton edge='end' color='inherit' onClick={handleClose} sx={{ position: 'absolute', right: 8, top: 8 }}>
                        <CloseIcon />
                    </IconButton>
                </DialogTitle>
                <DialogContent>
                    <TextField
                        label='Title'
                        required
                        fullWidth
                        value={title}
                        margin='normal'
                        onChange={(event) => {
                            setTitle(event.target.value)
                        }}
                    />
                    <TextField
                        label='Description'
                        required
                        fullWidth
                        value={description}
                        margin='normal'
                        multiline
                        minRows={4}
                        onChange={(event) => {
                            setDescription(event.target.value)
                        }}
                    />
                    <TextField
                        label='Group Capacity'
                        required
                        value={memberCapacity}
                        fullWidth
                        type='number'
                        margin='normal'
                        onChange={(event) => {
                            setmemberCapacity(event.target.value)
                        }}
                    />
                    <FormControl fullWidth margin='normal'>
                        <InputLabel htmlFor='max-width'>Language</InputLabel>
                        <Select
                            label='Language'
                            value={requiredLanguage}
                            onChange={(event) => {
                                setRequiredLanguage(event.target.value)
                            }}
                        >
                            {languages.map((name) => (
                                <MenuItem key={name} value={name}>
                                    {name}
                                </MenuItem>
                            ))}
                        </Select>
                    </FormControl>
                    <FormControl fullWidth margin='normal'>
                        <InputLabel htmlFor='max-width'>Platform</InputLabel>
                        <Select
                            label='Platform'
                            value={requiredPlatform}
                            onChange={(event) => {
                                setRequiredPlatform(event.target.value)
                            }}
                        >
                            {platforms.map((name) => (
                                <MenuItem key={name} value={name}>
                                    {name}
                                </MenuItem>
                            ))}
                        </Select>
                    </FormControl>
                    <FormControl fullWidth margin='normal'>
                        <h3 style={{ display: "flex", alignItems: "flex-start" }}>Tags:</h3>
                        <FormControl
                            sx={{
                                display: "flex",
                                alignItems: "center",
                                gap: "20px",
                                flexWrap: "wrap",
                                flexDirection: "row",
                                border: "2px solid lightgray",
                                padding: 1,
                                borderRadius: "4px",
                            }}
                        >
                            <div className={"container"}>
                                {tags.map((item, index) => (
                                    <Chip
                                        key={index}
                                        size="small"
                                        onDelete={() => handleDeleteTag(item, index)}
                                        label={item}
                                    />
                                ))}
                            </div>
                            <Input fullWidth
                                   value={currTag}
                                   onChange={handleChange}
                                   onKeyDown={handleKeyUp}
                            />
                        </FormControl>
                    </FormControl>
                    <FormControlLabel
                        control={
                            <Checkbox
                                value={micCamRequirement}
                                checked={micCamRequirement}
                                onChange={handleCheckboxChange}
                            />
                        }
                        label="Mic/Cam Required"
                    />
                </DialogContent>
                <DialogActions>
                    <Button onClick={handleClose}>Cancel</Button>
                    <Button type='submit' onClick={handleSubmit(onSubmit)}>
                        Edit
                    </Button>
                </DialogActions>
            </Dialog>
        </div>
    )
}
