class ank.utils.QueueEmbedMovieClip extends MovieClip
{
	static var _aQueue = new Array();
	static var _mcEnterFrame = _root.createEmptyMovieClip("_mcQueueEnterFrame",_root.getNextHighestDepth());
	function QueueEmbedMovieClip()
	{
		super();
	}
	function addToQueue(loc2)
	{
		ank.utils.QueueEmbedMovieClip._aQueue.push(loc2);
		if(ank.utils.QueueEmbedMovieClip._mcEnterFrame.onEnterFrame == undefined)
		{
			ank.utils.QueueEmbedMovieClip._mcEnterFrame.onEnterFrame = this.runQueue;
		}
	}
	function runQueue()
	{
		for(var loc2 in ank.utils.QueueEmbedMovieClip._aQueue)
		{
			loc2.method.apply(loc2.object,loc2.params);
			if(ank.utils.QueueEmbedMovieClip._aQueue.length == 0)
			{
				delete ank.utils.QueueEmbedMovieClip._mcEnterFrame.onEnterFrame;
			}
		}
	}
}
