import express from 'express';

// Constants
const PORT = 3000;
const HOST = '0.0.0.0';

// App
const app = express();
app.use(express.json())

app.get('/', (req: any, res: any) => {
	res.send('Mock HTTP Server!\n');
});

app.post("/api/:group/:id", (req: express.Request, res: express.Response) => {
	const group: string = req.params.group
	const id: string = req.params.id
	insertInto(group, id, req.body)
	res.send("ok")
})

app.get("/api/:group/:id", (req: express.Request, res: express.Response) => {
	const group: string = req.params.group
	const id: string = req.params.id
	const record = getByGroupAndId(group, id)
	if (record) {
		res.json(record)
	} else {
		res.status(404).send('not found')
	}
})

app.get("/api/:group", (req: express.Request, res: express.Response) => {
	const group: string = req.params.group
	const entities = getAllByGroup(group)
	res.json({items: entities})
})

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);

// DB
type Record = {id: string, createdAt: string, updatedAt: string}
const DB: Map<string,Map<string,Record>> = new Map<string,Map<string,Record>>();

function insertInto(group: string, id: string, record: {}) {
	const createdAt = getByGroupAndId(group, id)?.createdAt || new Date().toISOString()
	const updatedAt = new Date().toISOString()
	const recordToInsert = Object.assign({id: id, createdAt: createdAt, updatedAt: updatedAt}, record)
	groupDBOf(group).set(id, recordToInsert)
}

function getByGroupAndId(group: string, id: string): Record | null {
	const record = groupDBOf(group).get(id)
	if (record !== undefined) {
		return record
	}
	return null
}

function getAllByGroup(group: string): Record[] {
	return Array.from(groupDBOf(group).values())
}

function groupDBOf(group: string): Map<string,Record> {
	let groupDB = DB.get(group)
	if (!groupDB) {
		groupDB = new Map<string,Record>()
		DB.set(group, groupDB)
	}
	return groupDB
}